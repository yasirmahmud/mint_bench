`define E203_INSTR_SIZE 32
`define E203_RFIDX_WIDTH 5
`define E203_XLEN 32
`define E203_PC_SIZE 32

// Dummy definition for e203_exu_decode to resolve black-box violation
// The internal logic is not defined as it's not provided by the problem description.
// All outputs are driven to '0' to ensure defined values and avoid X-propagation in simulation.
module e203_exu_decode (
  input  [`E203_INSTR_SIZE-1:0] i_instr,
  input  [`E203_PC_SIZE-1:0] i_pc,
  input  i_prdt_taken,
  input  i_muldiv_b2b,
  input  i_misalgn,
  input  i_buserr,
  input  dbg_mode,

  output dec_misalgn,
  output dec_buserr,
  output dec_ilegl,

  output dec_rs1x0,
  output dec_rs2x0,
  output dec_rs1en,
  output dec_rs2en,
  output dec_rdwen,
  output [`E203_RFIDX_WIDTH-1:0] dec_rs1idx,
  output [`E203_RFIDX_WIDTH-1:0] dec_rs2idx,
  output [`E203_RFIDX_WIDTH-1:0] dec_rdidx,
  output [`E203_XLEN-1:0] dec_info,
  output [`E203_XLEN-1:0] dec_imm,
  output [`E203_PC_SIZE-1:0] dec_pc,

`ifdef E203_HAS_NICE
  input nice_xs_off,
  output dec_nice,
  output nice_cmt_off_ilgl_o,
`endif

  output dec_mulhsu,
  output dec_mul,
  output dec_div,
  output dec_rem,
  output dec_divu,
  output dec_remu,

  output dec_rv32,
  output dec_bjp,
  output dec_jal,
  output dec_jalr,
  output dec_bxx,

  output [`E203_RFIDX_WIDTH-1:0] dec_jalr_rs1idx,
  output [`E203_XLEN-1:0] dec_bjp_imm
);

  assign dec_misalgn = 1'b0;
  assign dec_buserr = 1'b0;
  assign dec_ilegl = 1'b0;

  assign dec_rs1x0 = 1'b0;
  assign dec_rs2x0 = 1'b0;
  assign dec_rs1en = 1'b0;
  assign dec_rs2en = 1'b0;
  assign dec_rdwen = 1'b0;
  assign dec_rs1idx = '0;
  assign dec_rs2idx = '0;
  assign dec_rdidx = '0;
  assign dec_info = '0;
  assign dec_imm = '0;
  assign dec_pc = '0;

`ifdef E203_HAS_NICE
  assign dec_nice = 1'b0;
  assign nice_cmt_off_ilgl_o = 1'b0;
`endif

  assign dec_mulhsu = 1'b0;
  assign dec_mul = 1'b0;
  assign dec_div = 1'b0;
  assign dec_rem = 1'b0;
  assign dec_divu = 1'b0;
  assign dec_remu = 1'b0;

  assign dec_rv32 = 1'b0;
  assign dec_bjp = 1'b0;
  assign dec_jal = 1'b0;
  assign dec_jalr = 1'b0;
  assign dec_bxx = 1'b0;

  assign dec_jalr_rs1idx = '0;
  assign dec_bjp_imm = '0;

endmodule
