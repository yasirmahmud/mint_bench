module alu32(
  input  logic [31:0] op_a,
  input  logic [31:0] op_b,
  input  logic [3:0]  opcode,
  output logic [31:0] result,
  output logic        zero,
  output logic        carry,
  output logic        overflow,
  output logic        negative
);

  logic [31:0] add_res;
  logic [31:0] sub_res;
  logic [31:0] and_res;
  logic [31:0] or_res;
  logic [31:0] xor_res;
  logic [31:0] sll_res;
  logic [31:0] srl_res;
  logic [31:0] sra_res;
  logic [31:0] slt_res;
  logic [32:0] add_ext;
  logic [32:0] sub_ext;
  logic        add_over;
  logic        sub_over;
  logic [4:0]  shamt;

  logic [15:0] debug_spare;

  logic [31:0] \always_comb ;

  assign shamt   = op_b[4:0];
  assign add_ext = {1'b0, op_a} + {1'b0, op_b};
  assign add_res = add_ext[31:0];
  assign sub_ext = {1'b0, op_a} + {1'b0, ~op_b} + 33'd1;
  assign sub_res = sub_ext[31:0];
  assign add_over = ((op_a[31] == op_b[31]) && (add_res[31] != op_a[31]));
  assign sub_over = ((op_a[31] != op_b[31]) && (sub_res[31] != op_a[31]));
  assign or_res  = op_a | op_b;
  assign xor_res = op_a ^ op_b;
  assign sll_res = op_a << shamt;
  assign srl_res = op_a >> shamt;
  assign sra_res = $signed(op_a) >>> shamt;
  assign slt_res = ($signed(op_a) < $signed(op_b)) ? 32'd1 : 32'd0;
  assign \always_comb  = ~(op_a ^ op_b);

  assign and_res = op_a && op_b;

  always_comb begin
    result   = 32'd0;
    zero     = 1'b0;
    carry    = 1'b0;
    overflow = 1'b0;
    negative = 1'b0;
    unique case (opcode)
      4'd0: begin
        result   = add_res;
        carry    = add_ext[32];
        overflow = add_over;
      end
      4'd1: begin
        result   = sub_res;
        carry    = ~sub_ext[32];
        overflow = sub_over;
      end
      4'd2: begin
        result = and_res;
      end
      4'd3: begin
        result = or_res;
      end
      4'd4: begin
        result = xor_res;
      end
      4'd5: begin
        result = sll_res;
      end
      4'd6: begin
        result = srl_res;
      end
      4'd7: begin
        result = sra_res;
      end
      4'd8: begin
        result = slt_res;
      end
      4'd9: begin
        result = op_a;
      end
      4'd10: begin
        result = op_b;
      end
      4'd11: begin
        result = \always_comb ;
      end
      default: begin
        result = 32'd0;
      end
    endcase
    zero     = (result == 32'd0);
    negative = result[31];
  end

endmodule