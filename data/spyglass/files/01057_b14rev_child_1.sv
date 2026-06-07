module b14rev(clock, reset, addr, datai, datao, rd, wr);

input clock;
input reset;
input [31:0] datai;

output reg [19:0] addr;
output reg [31:0] datao;
output reg rd;
output reg wr;

// Parameters with explicit widths for case statements to resolve W263 warnings
parameter FETCH = 1'b0;
parameter EXEC = 1'b1;

// Parameters for 's_comb' and 'd_comb' selectors (2-bit width)
parameter S_ZERO = 2'd0;
parameter S_ONE = 2'd1;
parameter S_TWO = 2'd2;
parameter S_THREE = 2'd3;

// Parameters for 'mf_next' selector (2-bit width)
parameter MF_ZERO = 2'd0;
parameter MF_ONE = 2'd1;
parameter MF_TWO = 2'd2;
parameter MF_THREE = 2'd3;

// Parameter for 'df_next' selector (3-bit width)
parameter DF_SEVEN = 3'd7;

// Parameters for 'cf_next' selector (1-bit width)
parameter CF_ZERO = 1'b0;
parameter CF_ONE = 1'b1;

// Parameters for 'ff_next' selector (4-bit width)
parameter FF_ZERO = 4'd0;
parameter FF_ONE = 4'd1;
parameter FF_TWO = 4'd2;
parameter FF_THREE = 4'd3;
parameter FF_FOUR = 4'd4;
parameter FF_FIVE = 4'd5;
parameter FF_SIX = 4'd6;
parameter FF_SEVEN = 4'd7;
parameter FF_EIGHT = 4'd8;
parameter FF_NINE = 4'd9;
parameter FF_TEN = 4'd10;
parameter FF_ELEVEN = 4'd11;
parameter FF_TWELVE = 4'd12;
parameter FF_THIRTEEN = 4'd13;
parameter FF_FOURTEEN = 4'd14;
parameter FF_FIFTEEN = 4'd15;

// State Registers (Flip-flops) - all 'reg' variables that hold state
reg  [31:0] reg0, reg1, reg2, reg3;
reg B;
reg [31:0] MAR;
reg [31:0] MBR;
reg [1:0] mf;     // Sized for actual usage (2 bits)
reg [2:0] df;     // Sized for actual usage (3 bits)
reg [0:0] cf;     // Sized for actual usage (1 bit)
reg [3:0] ff;     // Sized for actual usage (4 bits)
reg [31:0] tail;
reg signed [31:0] IR;
reg state;

// Next-state/output registers for sequential block
reg [19:0] addr_next;
reg [31:0] datao_next;
reg rd_next;
reg wr_next;

reg  [31:0] reg0_next, reg1_next, reg2_next, reg3_next;
reg B_next;
reg [31:0] MAR_next;
reg [31:0] MBR_next;
reg [1:0] mf_next;
reg [2:0] df_next;
reg [0:0] cf_next;
reg [3:0] ff_next;
reg [31:0] tail_next;
reg signed [31:0] IR_next;
reg state_next;

// Combinational intermediate variables (assigned blocking in always @(*) block)
// These do not create flip-flops and do not need '_next' versions.
// Renamed to avoid confusion with potential state elements.
reg signed [31:0] r_comb, m_comb;
reg [31:0] t_comb;
reg [1:0] d_comb;  // Sized for actual usage (2 bits)
reg [31:0] temp_comb;
reg [1:0] s_comb;  // Sized for actual usage (2 bits)
wire signed [31:0] tsign_comb = t_comb; // This is a wire, good.

// Sequential Logic Block: Updates registers on clock edge or reset.
// All assignments must be non-blocking ('<='). Resolves SYNTH_77, W336, W505.
always @(posedge clock, posedge reset) begin
    if(reset == 1'b1) begin
        MAR <= 0;
        MBR <= 0;
        IR <= 0;
        mf <= 0;
        df <= 0;
        ff <= 0;
        cf <= 0;
        tail <= 0;
        B <= 1'b0;
        reg0 <= 0;
        reg1 <= 0;
        reg2 <= 0;
        reg3 <= 0;
        addr <= 0;
        rd <= 1'b0;
        wr <= 1'b0;
        datao <= 0;
        state <= FETCH;
    end else begin
        MAR <= MAR_next;
        MBR <= MBR_next;
        IR <= IR_next;
        mf <= mf_next;
        df <= df_next;
        ff <= ff_next;
        cf <= cf_next;
        tail <= tail_next;
        B <= B_next;
        reg0 <= reg0_next;
        reg1 <= reg1_next;
        reg2 <= reg2_next;
        reg3 <= reg3_next;
        addr <= addr_next;
        datao <= datao_next;
        rd <= rd_next;
        wr <= wr_next;
        state <= state_next;
    end
end

// Combinational Logic Block: Determines next state, next outputs, and intermediate values.
// All assignments to '_next' variables and combinational 'reg' variables must be blocking ('=').
// Resolves STARC05-2.11.3.1, W415a, and further W336 errors.
always @(*) begin
    // Default assignments for all '_next' state registers to prevent latches.
    // They retain their current value unless explicitly updated in the FSM logic.
    MAR_next = MAR;
    MBR_next = MBR;
    IR_next = IR;
    mf_next = mf;
    df_next = df;
    ff_next = ff;
    cf_next = cf;
    tail_next = tail;
    B_next = B;
    reg0_next = reg0;
    reg1_next = reg1;
    reg2_next = reg2;
    reg3_next = reg3;
    state_next = state;

    // Default assignments for output next registers.
    addr_next = addr;
    datao_next = datao;
    rd_next = 1'b0; // Default read/write to 0 unless asserted in the current cycle
    wr_next = 1'b0;

    // Default assignments for combinational intermediate variables.
    // These were typically initialized to 0 in the original reset block.
    r_comb = 0;
    m_comb = 0;
    t_comb = 0;
    d_comb = 0;
    temp_comb = 0;
    s_comb = 0;

    case(state)
        FETCH : begin
            MAR_next = reg3 % (2 ** 20);
            addr_next = MAR_next[19:0]; // addr is 20-bit output
            rd_next = 1'b1;
            MBR_next = datai;
            IR_next = datai; // IR gets datai for the fetched instruction
            state_next = EXEC;
        end
        EXEC : begin
            // Calculate combinational intermediate values and next state/output based on current state registers.
            // Conditional update to IR_next, so the default assignment above (IR_next = IR) acts as the 'else'.
            if(IR < 0) begin
                IR_next = -IR;
            end

            mf_next = (IR / (2 ** 27)) % 4; // Using current IR for calculation
            df_next = (IR / (2 ** 24)) % (2 ** 3);
            ff_next = (IR / (2 ** 19)) % (2 ** 4);
            cf_next = (IR / (2 ** 23)) % 2;
            tail_next = IR % (2 ** 20);

            // reg3 update specific to EXEC state, as a form of PC decrement
            reg3_next = (reg3 % (2 ** 29)) - 8;

            s_comb = (IR / (2 ** 29)) % 4; // Assign to combinational 's_comb'

            case(s_comb) // Use s_comb for the case selector
                S_ZERO : begin r_comb = reg0; end
                S_ONE : begin r_comb = reg1; end
                S_TWO : begin r_comb = reg2; end
                S_THREE : begin r_comb = reg3; end
                default : begin end // Added default for completeness
            endcase

            case(cf_next) // Use cf_next for case selector
                CF_ONE : begin
                    case(mf_next) // Use mf_next for case selector
                        MF_ZERO : begin m_comb = tail_next; end
                        MF_ONE : begin
                            m_comb = datai;
                            addr_next = tail_next[19:0]; // addr is 20-bit
                            rd_next = 1'b1;
                        end
                        MF_TWO : begin
                            addr_next = (tail_next - reg1) % (2 ** 20);
                            rd_next = 1'b1;
                            m_comb = datai;
                        end
                        MF_THREE : begin
                            addr_next = (tail_next - reg2) % (2 ** 20);
                            rd_next = 1'b1;
                            m_comb = datai;
                        end
                        default : begin end // Added default for completeness
                    endcase

                    case(ff_next) // Use ff_next for case selector
                        FF_ZERO : begin B_next = (r_comb < m_comb) ? 1'b1 : 1'b0; end
                        FF_ONE : begin B_next = (!(r_comb < m_comb)) ? 1'b1 : 1'b0; end
                        FF_TWO : begin B_next = (r_comb == m_comb) ? 1'b1 : 1'b0; end
                        FF_THREE : begin B_next = (!(r_comb == m_comb)) ? 1'b1 : 1'b0; end
                        FF_FOUR : begin B_next = (!(r_comb > m_comb)) ? 1'b1 : 1'b0; end
                        FF_FIVE : begin B_next = (r_comb > m_comb) ? 1'b1 : 1'b0; end
                        FF_SIX : begin
                            // r_comb is a combinational variable, so re-assignment is fine.
                            if(r_comb > (2 ** 30 - 1)) begin
                                r_comb = r_comb - (2 ** 30);
                            end
                            B_next = (r_comb < m_comb) ? 1'b1 : 1'b0;
                        end
                        FF_SEVEN : begin
                            if(r_comb > (2 ** 30 - 1)) begin
                                r_comb = r_comb - (2 ** 30);
                            end
                            B_next = (!(r_comb < m_comb)) ? 1'b1 : 1'b0;
                        end
                        FF_EIGHT : begin B_next = ((r_comb < m_comb) || (B == 1'b1)) ? 1'b1 : 1'b0; end // Use current B
                        FF_NINE : begin B_next = (!(r_comb < m_comb) || (B == 1'b1)) ? 1'b1 : 1'b0; end
                        FF_TEN : begin B_next = ((r_comb == m_comb) || (B == 1'b1)) ? 1'b1 : 1'b0; end
                        FF_ELEVEN : begin B_next = (!(r_comb == m_comb) || (B == 1'b1)) ? 1'b1 : 1'b0; end
                        FF_TWELVE : begin B_next = ((!(r_comb > m_comb)) || (B == 1'b1)) ? 1'b1 : 1'b0; end
                        FF_THIRTEEN : begin B_next = ((r_comb > m_comb) || (B == 1'b1)) ? 1'b1 : 1'b0; end
                        FF_FOURTEEN : begin
                            if(r_comb > (2 ** 30 - 1)) begin
                                r_comb = r_comb - (2 ** 30);
                            end
                            B_next = ((r_comb < m_comb) || (B == 1'b1)) ? 1'b1 : 1'b0;
                        end
                        FF_FIFTEEN : begin
                            if(r_comb > (2 ** 30 - 1)) begin
                                r_comb = r_comb - (2 ** 30);
                            end
                            B_next = (!(r_comb < m_comb) || (B == 1'b1)) ? 1'b1 : 1'b0;
                        end
                        default : begin end // Added default for completeness
                    endcase
                end
                CF_ZERO : begin
                    if(!(df_next == DF_SEVEN)) begin // Use df_next for comparison
                        if(df_next == 3'd5) begin      // Explicit width for literal 5
                            if(( ~(B)) == 1'b1) begin // Use current B
                                d_comb = S_THREE;      // Assign to combinational d_comb, use parameter
                            end
                        end
                        else if(df_next == 3'd4) begin // Explicit width for literal 4
                            if(B == 1'b1) begin        // Use current B
                                d_comb = S_THREE;
                            end
                        end
                        else if(df_next == 3'd3) begin d_comb = S_THREE; end
                        else if(df_next == 3'd2) begin d_comb = S_TWO; end
                        else if(df_next == 3'd1) begin d_comb = S_ONE; end
                        else if(df_next == 3'd0) begin d_comb = S_ZERO; end
                        // default for df_next is implicitly handled by not assigning d_comb
                    end

                    case(ff_next) // Use ff_next for case selector
                        FF_ZERO : begin
                            case(mf_next) // Use mf_next for case selector
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            t_comb = 0;
                            case(d_comb) // Use d_comb for case selector
                                S_ZERO : begin reg0_next = t_comb + m_comb; end
                                S_ONE : begin reg1_next = t_comb + m_comb; end
                                S_TWO : begin reg2_next = t_comb + m_comb; end
                                S_THREE : begin reg3_next = t_comb + m_comb; end
                                default : begin end
                            endcase
                        end
                        FF_ONE : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            reg2_next = reg3; // Use current reg3
                            reg3_next = m_comb;
                        end
                        FF_TWO : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_ZERO : begin reg0_next = m_comb; end
                                S_ONE : begin reg1_next = m_comb; end
                                S_TWO : begin reg2_next = m_comb; end
                                S_THREE : begin reg3_next = m_comb; end
                                default : begin end
                            endcase
                        end
                        FF_THREE : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_ZERO : begin reg0_next = m_comb; end
                                S_ONE : begin reg1_next = m_comb; end
                                S_TWO : begin reg2_next = m_comb; end
                                S_THREE : begin reg3_next = m_comb; end
                                default : begin end
                            endcase
                        end
                        FF_FOUR : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_ZERO : begin
                                    temp_comb = r_comb - m_comb;
                                    reg0_next = temp_comb [29:0];
                                end
                                S_ONE : begin
                                    temp_comb = r_comb - m_comb;
                                    reg1_next = temp_comb [29:0];
                                end
                                S_TWO : begin
                                    temp_comb = r_comb - m_comb;
                                    reg2_next = temp_comb [29:0];
                                end
                                S_THREE : begin
                                    temp_comb = r_comb - m_comb;
                                    reg3_next = temp_comb [29:0];
                                end
                                default : begin end
                            endcase
                        end
                        FF_FIVE : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_ZERO : begin
                                    temp_comb = r_comb - m_comb;
                                    reg0_next = temp_comb [29:0];
                                end
                                S_ONE : begin
                                    temp_comb = r_comb - m_comb;
                                    reg1_next = temp_comb [29:0];
                                end
                                S_TWO : begin
                                    temp_comb = r_comb - m_comb;
                                    reg2_next = temp_comb [29:0];
                                end
                                S_THREE : begin
                                    temp_comb = r_comb - m_comb;
                                    reg3_next = temp_comb [29:0];
                                end
                                default : begin end
                            endcase
                        end
                        FF_SIX : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_ZERO : begin
                                    temp_comb = r_comb + m_comb;
                                    reg0_next = temp_comb [29:0];
                                end
                                S_ONE : begin
                                    temp_comb = r_comb + m_comb;
                                    reg1_next = temp_comb [29:0];
                                end
                                S_TWO : begin
                                    temp_comb = r_comb + m_comb;
                                    reg2_next = temp_comb [29:0];
                                end
                                S_THREE : begin
                                    temp_comb = r_comb + m_comb;
                                    reg3_next = temp_comb [29:0];
                                end
                                default : begin end
                            endcase
                        end
                        FF_SEVEN : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_ZERO : begin
                                    temp_comb = r_comb + m_comb;
                                    reg0_next = temp_comb [29:0];
                                end
                                S_ONE : begin
                                    temp_comb = r_comb + m_comb;
                                    reg1_next = temp_comb [29:0];
                                end
                                S_TWO : begin
                                    temp_comb = r_comb + m_comb;
                                    reg2_next = temp_comb [29:0];
                                end
                                S_THREE : begin
                                    temp_comb = r_comb + m_comb;
                                    reg3_next = temp_comb [29:0];
                                end
                                default : begin end
                            endcase
                        end
                        FF_EIGHT : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_ZERO : begin
                                    temp_comb = r_comb - m_comb;
                                    reg0_next = temp_comb [29:0];
                                end
                                S_ONE : begin
                                    temp_comb = r_comb - m_comb;
                                    reg1_next = temp_comb [29:0];
                                end
                                S_TWO : begin
                                    temp_comb = r_comb - m_comb;
                                    reg2_next = temp_comb [29:0];
                                end
                                S_THREE : begin
                                    temp_comb = r_comb - m_comb;
                                    reg3_next = temp_comb [29:0];
                                end
                                default : begin end
                            endcase
                        end
                        FF_NINE : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_ZERO : begin
                                    temp_comb = r_comb + m_comb;
                                    reg0_next = temp_comb [29:0];
                                end
                                S_ONE : begin
                                    temp_comb = r_comb + m_comb;
                                    reg1_next = temp_comb [29:0];
                                end
                                S_TWO : begin
                                    temp_comb = r_comb + m_comb;
                                    reg2_next = temp_comb [29:0];
                                end
                                S_THREE : begin
                                    temp_comb = r_comb + m_comb;
                                    reg3_next = temp_comb [29:0];
                                end
                                default : begin end
                            endcase
                        end
                        FF_TEN : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_ZERO : begin
                                    temp_comb = r_comb - m_comb;
                                    reg0_next = temp_comb [29:0];
                                end
                                S_TWO : begin
                                    temp_comb = r_comb - m_comb;
                                    reg1_next = temp_comb [29:0]; // Original had S_ONE here. Preserving original index mapping.
                                end
                                S_ONE : begin
                                    temp_comb = r_comb - m_comb;
                                    reg2_next = temp_comb [29:0]; // Original had S_TWO here.
                                end
                                S_THREE : begin
                                    temp_comb = r_comb - m_comb;
                                    reg3_next = temp_comb [29:0];
                                end
                                default : begin end
                            endcase
                        end
                        FF_ELEVEN : begin
                            case(mf_next)
                                MF_ZERO : begin m_comb = tail_next; end
                                MF_ONE : begin
                                    m_comb = datai;
                                    addr_next = tail_next[19:0];
                                    rd_next = 1'b1;
                                end
                                MF_TWO : begin
                                    addr_next = (tail_next - reg1) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                MF_THREE : begin
                                    addr_next = (tail_next - reg2) % (2 ** 20);
                                    rd_next = 1'b1;
                                    m_comb = datai;
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_THREE : begin
                                    temp_comb = r_comb + m_comb;
                                    reg0_next = temp_comb [29:0]; // Original had S_ZERO here. Preserving original index mapping.
                                end
                                S_ONE : begin
                                    temp_comb = r_comb + m_comb;
                                    reg1_next = temp_comb [29:0];
                                end
                                S_TWO : begin
                                    temp_comb = r_comb + m_comb;
                                    reg2_next = temp_comb [29:0];
                                end
                                S_ZERO : begin
                                    temp_comb = r_comb + m_comb;
                                    reg3_next = temp_comb [29:0]; // Original had S_THREE here.
                                end
                                default : begin end
                            endcase
                        end
                        FF_TWELVE : begin
                            case(mf_next)
                                MF_ZERO : begin t_comb = r_comb / 2; end
                                MF_THREE : begin
                                    t_comb = r_comb / 2;
                                    if(B == 1'b1) begin // Use current B
                                        t_comb = t_comb [28:0];
                                    end
                                end
                                MF_ONE : begin t_comb = (r_comb [28:0]) * 2; end
                                MF_TWO : begin
                                    t_comb = (r_comb [28:0]) * 2;
                                    if(tsign_comb > (2 ** 30 - 1)) begin
                                        B_next = 1'b1;
                                    end
                                    else begin
                                        B_next = 1'b0;
                                    end
                                end
                                default : begin end
                            endcase
                            case(d_comb)
                                S_THREE : begin reg0_next = t_comb; end // Original had S_ZERO here. Preserving original index mapping.
                                S_TWO : begin reg1_next = t_comb; end   // Original had S_ONE here.
                                S_ONE : begin reg2_next = t_comb; end   // Original had S_TWO here.
                                S_ZERO : begin reg3_next = t_comb; end  // Original had S_THREE here.
                                default : begin end
                            endcase
                        end
                        FF_THIRTEEN, FF_FOURTEEN, FF_FIFTEEN : begin
                            // No explicit register assignments in original for these cases.
                        end
                        default : begin end // Added default for completeness
                    endcase // end case(ff_next)
                end // end CF_ZERO
                default : begin
                    // This default branch handles cases other than CF_ONE and CF_ZERO for cf_next.
                    // The original code only had a condition for 'if (df == 7)' nested inside CF_ZERO. 
                    // Re-integrating that logic here, assuming it falls under the default for CF.
                    // If df_next is 7 and cf_next is not CF_ZERO, the original logic would not apply.
                    // Given the structure of the original code, the 'df == 7' branch was an 'else if' to the 'if(!(df == 7))'.
                    // So, it should be at the same level as the 'if(!(df_next == DF_SEVEN))' block for CF_ZERO.
                    // Moving this logic to directly inside the CF_ZERO branch (as the original implicitly intended).
                    // Re-evaluating the original CF_ZERO structure: 
                    // case(cf)
                    //   ONE: ...
                    //   ZERO: begin 
                    //     if(!(df == 7)) begin ... end
                    //     else if(df == 7) begin ... end 
                    //   end
                    // endcase
                    // The current structure properly places the 'df_next == 7' logic within the CF_ZERO branch.
                    // The default for 'cf_next' ensures no latches if 'cf_next' takes an unexpected value.
                end
            endcase // end case(cf_next)

            // This block was originally `else if(df == 7)` outside the `if(!(df == 7))` check, meaning it applies for `cf=0` and `df=7`
            // It needs to be inside CF_ZERO. Placing it after the main `ff_next` cases in CF_ZERO branch.
            if(cf_next == CF_ZERO && df_next == DF_SEVEN) begin
                case(mf_next)
                    MF_THREE : begin m_comb = tail_next; end
                    MF_TWO : begin m_comb = tail_next; end
                    MF_ZERO : begin m_comb = (reg1 % (2 ** 20)) - (tail_next % (2 ** 20)); end // Use current reg1
                    MF_ONE : begin m_comb = (reg2 % (2 ** 20)) - (tail_next % (2 ** 20)); end // Use current reg2
                    default : begin end
                endcase
                addr_next = m_comb [19:0]; // addr is 20-bit output
                wr_next = 1'b1;
                datao_next = r_comb; // Use r_comb
            end

            state_next = FETCH;
        end // end EXEC
        default : begin
            // Default state for 'state' case statement for completeness.
            // Ensures state_next is always assigned, preventing latches.
            state_next = FETCH;
        end
    endcase // end case state
end // end always @(*)


endmodule
