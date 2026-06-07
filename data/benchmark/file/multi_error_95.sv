module Decoder(
    input  logic [15:0] instr,
    output logic [3:0]  alu_op,
    output logic        reg_write,
    output logic        mem_read,
    output logic        mem_write,
    output logic        branch,
    output logic [7:0]  imm8,
    output logic [15:0] imm16,
    output logic [2:0]  src_a,
    output logic [2:0]  src_b,
    output logic [2:0]  dst
);

  wire [3:0] opcode = instr[15:12];
  wire [2:0] rd_f   = instr[11:9];
  wire [2:0] ra_f   = instr[8:6];
  wire [2:0] rb_f   = instr[5:3];
  wire [2:0] shamt  = instr[2:0];
  wire [7:0] imm8_i = instr[7:0];
  wire [1:0] addr_mode = instr[1:0];
  wire       imm_neg = imm8_i[7];
  wire       cond_zero = (imm8_i == 8'h00);

  wire [15:0] status_bus = instr;
  wire [7:0]  status_flags;
  assign status_flags = status_bus;
  wire        is_special = status_flags[0];

  logic [4:0] debug_shadow;

  always_comb begin
    alu_op    = 4'h0;
    reg_write = 1'b0;
    mem_read  = 1'b0;
    mem_write = 1'b0;
    branch    = 1'b0;
    imm8      = imm8_i;
    imm16     = {{8{imm_neg}}, imm8_i};
    src_a     = ra_f;
    src_b     = rb_f;
    dst       = rd_f;

    case (opcode)
      4'h0: begin
        alu_op    = is_special ? 4'hF : 4'h0;
        reg_write = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        branch    = 1'b0;
      end
      4'h1: begin
        alu_op    = 4'h1;
        reg_write = 1'b1;
        src_a     = ra_f;
        src_b     = rb_f;
      end
      4'h2: begin
        alu_op    = 4'h1;
        reg_write = 1'b1;
        src_a     = ra_f;
        src_b     = 3'd0;
        imm16     = {{8{imm_neg}}, imm8_i};
      end
      4'h3: begin
        alu_op    = 4'h1;
        reg_write = 1'b1;
        mem_read  = 1'b1;
        src_a     = ra_f;
        src_b     = rb_f;
      end
      4'h4: begin
        alu_op    = 4'h1;
        mem_write = 1'b1;
        reg_write = 1'b0;
        src_a     = ra_f;
        src_b     = rb_f;
      end
      4'h5: begin
        alu_op    = 4'h2;
        reg_write = 1'b1;
        src_a     = ra_f;
        src_b     = rb_f;
      end
      4'h6: begin
        alu_op    = 4'h3;
        reg_write = 1'b1;
        src_a     = ra_f;
        src_b     = rb_f;
      end
      4'h7: begin
        alu_op    = 4'h4;
        reg_write = 1'b1;
        src_a     = ra_f;
        src_b     = rb_f;
      end
      4'h8: begin
        alu_op    = 4'h5;
        reg_write = 1'b1;
        src_a     = ra_f;
        src_b     = shamt;
      end
      4'h9: begin
        alu_op    = 4'h0;
        branch    = (~cond_zero) | is_special;
        reg_write = 1'b0;
        imm16     = {{8{imm_neg}}, imm8_i};
      end
      4'hA: begin
        alu_op    = 4'h6;
        reg_write = 1'b1;
        src_a     = 3'd0;
        src_b     = 3'd0;
        imm16     = {imm8_i, 8'h00};
      end
      4'hB: begin
        alu_op    = 4'h7;
        reg_write = 1'b0;
        src_a     = ra_f;
        src_b     = rb_f;
      end
      4'hC: begin
        alu_op    = 4'h0;
        reg_write = 1'b1;
        src_a     = ra_f;
        src_b     = rb_f;
      end
      4'hD: begin
        alu_op    = 4'h8;
        reg_write = 1'b1;
        src_a     = ra_f;
        src_b     = rb_f;
      end
      4'hE: begin
        alu_op    = 4'h0;
        branch    = 1'b1;
        reg_write = 1'b0;
        imm16     = {4'b0000, rd_f, ra_f, rb_f, shamt};
      end
      4'hF: begin
        if (addr_mode == 2'b00) begin
          alu_op    = is_special ? 4'h9 : 4'hA;
          reg_write = 1'b1;
        end else if (addr_mode == 2'b01) begin
          alu_op    = 4'hB;
          reg_write = 1'b1;
        end else if (addr_mode == 2'b10) begin
          alu_op    = 4'hC;
          reg_write = 1'b1;
        end else begin
          alu_op    = 4'hD;
          reg_write = 1'b1;
        end
      end
      default: begin
        alu_op    = 4'h0;
      end
    endcase
  end
endmodule