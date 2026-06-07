`define XPR_LEN 32
`define ALU_OP_WIDTH 4
`define SHAMT_WIDTH 5

// ALU Opcodes
`define ALU_OP_ADD  4'b0000
`define ALU_OP_SLL  4'b0001
`define ALU_OP_XOR  4'b0010
`define ALU_OP_OR   4'b0011
`define ALU_OP_AND  4'b0100
`define ALU_OP_SRL  4'b0101
`define ALU_OP_SEQ  4'b0110
`define ALU_OP_SNE  4'b0111
`define ALU_OP_SUB  4'b1000
`define ALU_OP_SRA  4'b1001
`define ALU_OP_SLT  4'b1010
`define ALU_OP_SGE  4'b1011
`define ALU_OP_SLTU 4'b1100
`define ALU_OP_SGEU 4'b1101

module vscale_alu(
                  input [`ALU_OP_WIDTH-1:0] op,
                  input [`XPR_LEN-1:0]      in1,
                  input [`XPR_LEN-1:0]      in2,
                  output reg [`XPR_LEN-1:0] out
                  );

   // Define a localparam to store the constant replication count
   // This resolves potential SpyGlass syntax issues when macros are directly used
   // in the replication count expression {N{item}}.
   localparam C_XPR_LEN_MINUS_1 = `XPR_LEN - 1;

   wire [`SHAMT_WIDTH-1:0]                  shamt;

   assign shamt = in2[`SHAMT_WIDTH-1:0];

   always @(*) begin
      case (op)
        `ALU_OP_ADD : out = in1 + in2;
        `ALU_OP_SLL : out = in1 << shamt;
        `ALU_OP_XOR : out = in1 ^ in2;
        `ALU_OP_OR : out = in1 | in2;
        `ALU_OP_AND : out = in1 & in2;
        `ALU_OP_SRL : out = in1 >> shamt;
        `ALU_OP_SEQ : out = {(C_XPR_LEN_MINUS_1){1'b0}, in1 == in2};
        `ALU_OP_SNE : out = {(C_XPR_LEN_MINUS_1){1'b0}, in1 != in2};
        `ALU_OP_SUB : out = in1 - in2;
        `ALU_OP_SRA : out = $signed(in1) >>> shamt;
        `ALU_OP_SLT : out = {(C_XPR_LEN_MINUS_1){1'b0}, $signed(in1) < $signed(in2)};
        `ALU_OP_SGE : out = {(C_XPR_LEN_MINUS_1){1'b0}, $signed(in1) >= $signed(in2)};
        `ALU_OP_SLTU : out = {(C_XPR_LEN_MINUS_1){1'b0}, in1 < in2};
        `ALU_OP_SGEU : out = {(C_XPR_LEN_MINUS_1){1'b0}, in1 >= in2};
        default : out = 0;
      endcase // case op
   end


endmodule
