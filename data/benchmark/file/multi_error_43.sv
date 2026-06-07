module alu #(parameter int WIDTH = 32) (
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    input  logic [3:0]       opcode,
    input  logic             cin,
    output logic [WIDTH-1:0] result,
    output logic             carry_out,
    output logic             overflow,
    output logic             zero,
    output logic             less_than,
    output logic             equal
);

localparam int SHAMT_W = (WIDTH < 2) ? 1 : $clog2(WIDTH);

logic [WIDTH-1:0] and_res;
logic [WIDTH-1:0] or_res;
logic [WIDTH-1:0] xor_res;
logic [WIDTH-1:0] sll_res;
logic [WIDTH-1:0] srl_res;
logic [WIDTH-1:0] sra_res;

logic [SHAMT_W-1:0] shamt;

logic [WIDTH:0] add_ext;
logic [WIDTH:0] adc_ext;
logic [WIDTH:0] sub_ext;

logic a_msb;
logic b_msb;
logic add_sum_msb;
logic sub_sum_msb;
logic adc_sum_msb;

logic add_overflow_w;
logic sub_overflow_w;
logic addc_overflow_w;

logic [WIDTH-1:0] debug_shadow;

assign shamt = b[SHAMT_W-1:0];
assign and_res = a & b;
assign or_res  = a | b;
assign xor_res = a ^ b;
assign sll_res = a << shamt;
assign srl_res = a >> shamt;
assign sra_res = $signed(a) >>> shamt;

assign add_ext = {1'b0, a} + {1'b0, b};
assign adc_ext = {1'b0, a} + {1'b0, b} + {{WIDTH{1'b0}}, cin};
assign sub_ext = {1'b0, a} + {1'b0, ~b} + {{WIDTH{1'b0}}, 1'b1};

assign a_msb = a[WIDTH-1];
assign b_msb = b[WIDTH-1];
assign add_sum_msb = add_ext[WIDTH-1];
assign sub_sum_msb = sub_ext[WIDTH-1];
assign adc_sum_msb = adc_ext[WIDTH-1];

assign add_overflow_w  = ( a_msb &  b_msb & ~add_sum_msb) | (~a_msb & ~b_msb &  add_sum_msb);
assign sub_overflow_w  = ( a_msb & ~b_msb & ~sub_sum_msb) | (~a_msb &  b_msb &  sub_sum_msb);
assign addc_overflow_w = ( a_msb &  b_msb & ~adc_sum_msb) | (~a_msb & ~b_msb &  adc_sum_msb);

assign equal = (a == b);
assign less_than = ($signed(a) < $signed(b));
assign zero = (result == {WIDTH{1'b0}});

always_comb begin
    result   = '0;
    overflow = 1'b0;
    unique case (opcode)
        4'h0: begin
            result    = add_ext[WIDTH-1:0];
            carry_out = add_ext[WIDTH];
            overflow  = add_overflow_w;
        end
        4'h1: begin
            result    = sub_ext[WIDTH-1:0];
            carry_out = ~sub_ext[WIDTH];
            overflow  = sub_overflow_w;
        end
        4'h2: begin
            result    = and_res;
            overflow  = 1'b0;
        end
        4'h3: begin
            result    = or_res;
            carry_out = 1'b0;
            overflow  = 1'b0;
        end
        4'h4: begin
            result    = xor_res;
            carry_out = 1'b0;
            overflow  = 1'b0;
        end
        4'h5: begin
            result    = sll_res;
            carry_out = 1'b0;
            overflow  = 1'b0;
        end
        4'h6: begin
            result    = srl_res;
            carry_out = 1'b0;
            overflow  = 1'b0;
        end
        4'h7: begin
            result    = sra_res;
            carry_out = 1'b0;
            overflow  = 1'b0;
        end
        4'h8: begin
            result    = {{WIDTH-1{1'b0}}, ($signed(a) < $signed(b))};
            carry_out = 1'b0;
            overflow  = 1'b0;
        end
        4'h9: begin
            result    = {{WIDTH-1{1'b0}}, (a < b)};
            carry_out = 1'b0;
            overflow  = 1'b0;
        end
        4'hA: begin
            result    = adc_ext[WIDTH-1:0];
            carry_out = adc_ext[WIDTH];
            overflow  = addc_overflow_w;
        end
        4'hB: begin
            result    = a;
            carry_out = 1'b0;
            overflow  = 1'b0;
        end
        4'hC: begin
            result    = b;
            carry_out = 1'b0;
            overflow  = 1'b0;
        end
        default: begin
            result    = '0;
            carry_out = 1'b0;
            overflow  = 1'b0;
        end
    endcase
end

endmodule