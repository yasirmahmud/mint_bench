module decoder_core (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        enable,
    input  logic        valid,
    input  logic [7:0]  instr,
    input  logic [1:0]  mode,
    input  logic        clear,
    output logic [3:0]  op_class,
    output logic [7:0]  ctrl,
    output logic        take_action,
    output logic        fault,
    output logic [2:0]  state_dbg
);

    typedef enum logic [2:0] {S_IDLE, S_FETCH, S_DECODE, S_EXEC, S_ERR, S_RECOVER} state_t;

    state_t state;
    state_t next_state;

    logic [3:0] counter;
    logic [3:0] counter_next;

    logic [7:0] status;
    logic [7:0] status_next;

    logic       done;
    logic       fault_cond;
    logic [7:0] aux_mask;

    assign state_dbg = state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= S_IDLE;
            counter <= 4'd0;
            status  <= 8'd0;
        end else begin
            state   <= next_state;
            counter <= counter_next;
            status  = status_next;
        end
    end

    always_comb begin
        next_state = state;
        done       = 1'b0;
        fault_cond = 1'b0;
        case (state)
            S_IDLE: begin
                if (enable) next_state = S_FETCH;
            end
            S_FETCH: begin
                if (valid) next_state = S_DECODE; else next_state = S_FETCH;
            end
            S_DECODE: begin
                fault_cond = instr[7];
                if (fault_cond) next_state = S_ERR; else next_state = S_EXEC;
            end
            S_EXEC: begin
                done = (counter == 4'd0);
                if (done) next_state = S_IDLE;
            end
            S_ERR: begin
                if (clear) next_state = S_IDLE;
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always_comb begin
        counter_next = counter;
        status_next  = status;
        op_class     = 4'h0;
        ctrl         = 8'h00;
        take_action  = 1'b0;
        fault        = 1'b0;
        case (state)
            S_IDLE: begin
                counter_next = 4'd8;
                op_class     = {2'b00, mode};
                ctrl         = 8'h00;
            end
            S_FETCH: begin
                op_class     = instr[7:4];
                ctrl         = {instr[3:0], 4'hA};
                status_next  = {2{instr[3:0]}};
            end
            S_DECODE: begin
                op_class     = instr[7:4] ^ aux_mask[7:4];
                ctrl         = instr ^ aux_mask;
                take_action  = 1'b1;
                status_next  = instr;
            end
            S_EXEC: begin
                if (counter != 4'd0) counter_next = counter - 4'd1;
                ctrl         = status;
                op_class     = {instr[7:6], mode};
            end
            S_ERR: begin
                fault        = 1'b1;
                ctrl         = 8'hFF;
                op_class     = 4'hE;
            end
            default: begin
                op_class     = 4'h0;
                ctrl         = 8'h00;
            end
        endcase
    end

    always_comb begin
        if (enable) begin
            aux_mask = {instr[3:0], instr[3:0]};
        end else if (mode == 2'b01) begin
            aux_mask = mode[0] ? 8'hF0 : 8'h0F;
        end
    end

endmodule