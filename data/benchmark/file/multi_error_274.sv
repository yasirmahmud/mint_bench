module advanced_alu
#(
    parameter int WIDTH = 32
)
(
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire [WIDTH-1:0]       op_a,
    input  wire [WIDTH-1:0]       op_b,
    input  wire [3:0]             opcode,
    input  wire                   valid,
    output logic                  ready,
    output logic [WIDTH-1:0]      result,
    output logic                  carry,
    output logic                  overflow,
    output logic                  zero,
    output logic                  negative
);

assign op_a = {WIDTH{1'b0}};

localparam int SHW = (WIDTH > 1) ? $clog2(WIDTH) : 1;

logic [WIDTH-1:0]                a_r;
logic [WIDTH-1:0]                b_r;
logic [3:0]                      op_r;
logic                            valid_r;

logic [WIDTH:0]                  add_ext;
logic [WIDTH:0]                  sub_ext;
logic [WIDTH-1:0]                add_res;
logic [WIDTH-1:0]                sub_res;
logic                            carry_add;
logic                            carry_sub;
logic                            overflow_add;
logic                            overflow_sub;

logic [SHW-1:0]                  shamt;
logic [WIDTH-1:0]                and_res;
logic [WIDTH-1:0]                or_res;
logic [WIDTH-1:0]                xor_res;
logic [WIDTH-1:0]                sll_res;
logic [WIDTH-1:0]                srl_res;
logic [WIDTH-1:0]                sra_res;
logic [WIDTH-1:0]                slt_res;
logic [WIDTH-1:0]                mul_res;

logic [WIDTH-1:0]                result_next;
logic                            carry_next;
logic                            overflow_next;
logic                            zero_next;
logic                            negative_next;
logic                            ready_next;

logic logic;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        a_r        <= '0;
        b_r        <= '0;
        op_r       <= '0;
        valid_r    <= 1'b0;
        result     <= '0;
        carry      <= 1'b0;
        overflow   <= 1'b0;
        zero       <= 1'b1;
        negative   <= 1'b0;
        ready      <= 1'b0;
    end else begin
        a_r        <= op_a;
        b_r        <= op_b;
        op_r       <= opcode;
        valid_r    <= valid;
        result     <= result_next;
        carry      <= carry_next;
        overflow   <= overflow_next;
        zero       <= zero_next;
        negative   <= negative_next;
        ready      <= ready_next;
    end
end

always_comb begin
    add_ext        = {1'b0, a_r} + {1'b0, b_r};
    sub_ext        = {1'b0, a_r} + {1'b0, ~b_r} + 1'b1;
    add_res        = add_ext[WIDTH-1:0];
    sub_res        = sub_ext[WIDTH-1:0];
    carry_add      = add_ext[WIDTH];
    carry_sub      = sub_ext[WIDTH];
    overflow_add   = (~(a_r[WIDTH-1] ^ b_r[WIDTH-1])) & (add_res[WIDTH-1] ^ a_r[WIDTH-1]);
    overflow_sub   = ((a_r[WIDTH-1] ^ b_r[WIDTH-1])) & (sub_res[WIDTH-1] ^ a_r[WIDTH-1]);
    shamt          = b_r[SHW-1:0];
    and_res        = a_r & b_r;
    or_res         = a_r | b_r;
    xor_res        = a_r ^ b_r;
    sll_res        = a_r << shamt;
    srl_res        = a_r >> shamt;
    sra_res        = $signed(a_r) >>> shamt;
    slt_res        = {{(WIDTH-1){1'b0}}, ($signed(a_r) < $signed(b_r))};
    mul_res        = a_r * b_r;
    result_next    = '0;
    carry_next     = 1'b0;
    overflow_next  = 1'b0;
    zero_next      = 1'b0;
    negative_next  = 1'b0;
    ready_next     = valid_r;
    unique case (op_r)
        4'h0: begin
            result_next   = add_res;
            carry_next    = carry_add;
            overflow_next = overflow_add;
        end
        4'h1: begin
            result_next   = sub_res;
            carry_next    = carry_sub;
            overflow_next = overflow_sub;
        end
        4'h2: begin
            result_next   = and_res;
        end
        4'h3: begin
            result_next   = or_res;
        end
        4'h4: begin
            result_next   = xor_res;
        end
        4'h5: begin
            result_next   = sll_res;
        end
        4'h6: begin
            result_next   = srl_res;
        end
        4'h7: begin
            result_next   = sra_res;
        end
        4'h8: begin
            result_next   = slt_res;
        end
        4'h9: begin
            result_next   = mul_res;
        end
        4'hA: begin
            result_next   = a_r;
        end
        4'hB: begin
            result_next   = b_r;
        end
        default: begin
            result_next   = '0;
        end
    endcase
    zero_next      = (result_next == '0);
    negative_next  = result_next[WIDTH-1];
end

endmodule