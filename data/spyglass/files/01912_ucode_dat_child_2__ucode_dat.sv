module ucode_dat (
                             instr_index,
                             instr_narg,
                             instr_indexbyte1,
                             instr_indexbyte2,
                             ie_stall_ucode,
                             ie_kill_ucode,
                             u_f02,
                             u_f06,
                             u_f08,
                             u_f09,
                             u_f10,
                             u_f11,
                             u_f12,
                             u_f13,
                             u_f14,
                             u_f15,
                             u_f16,
                             u_f19,
                             u_f20,
                             iu_optop,
                             alu_data,
                             archi_data,
                             ucode_addr_d,
                             rs1,
                             rs1_b,
                             rs2,
                             dreg,
                             sm,
                             sin,
                             reset_l,
                             clk,
                             so,
                             u_addr_st_rd,
                             u_areg0,
                             ucode_porta,
                             ucode_portb,
                             ucode_portc,
                             ialu_a,
                             m_adder_porta,
                             m_adder_portb,
                             a_oprd, 
                             a_oprd_0_l, 
                             b_oprd, 
                             reg5_31 
                   );

//  `include "../../common/ucode.h"

input    [7:0] instr_index;        // index of method vector table, instruc
input    [7:0] instr_narg;         // # of arguments, instruction
input    [7:0] instr_indexbyte1;   // indexbyte1 of the opcode, instruction
input    [7:0] instr_indexbyte2;   // indexbyte2 of the opcode, instruction
input          ie_stall_ucode;     // IE unit holds off ucode execution
input          ie_kill_ucode;      // IE unit kills     ucode execution

input    [1:0] u_f02;              // Field_02: Ucode and Stack         RD
input    [3:0] u_f06;              // Field_06: Integer Unit ALU a_operand
input    [2:0] u_f08;              // Field_08: Read_port_A of temp_regs
input    [2:0] u_f09;              // Field_09: Read_port_B of temp_regs
input    [2:0] u_f10;              // Field_10: Write_port_A of temp_reg SEL
input    [2:0] u_f11;              // Field_11: Write_port_A of temp_reg WT
input    [1:0] u_f12;              // Field_12: Write_port_B0 of temp_reg SEL
input    [1:0] u_f13;              // Field_13: Write_port_B1 of temp_reg SEL
input    [1:0] u_f14;              // Field_14: Write_port_B0 of temp_reg WT
input          u_f15;              // Field_15: Write_port_B1 of temp_reg WT
input    [1:0] u_f16;              // Field_16: Sel reg2/3/6->dat/stk cache
input    [3:0] u_f19;              // field_19: Mem_adder a_operand
input    [3:0] u_f20;              // field_20: Mem_adder b_operand

input   [31:0] iu_optop;           // the optop IU sent to start ucode
input   [31:0] alu_data;           // ieu_alu data output
input   [31:0] archi_data;         // architecture register output
input   [31:0] ucode_addr_d;       // memory_adder output

input   [31:0] rs1;                // always  rs1  = reg[nxt_rs1]
input   [31:0] rs1_b;              // always  rs1  = reg[nxt_rs1] buffered
input   [31:0] rs2;                // Initial rs2  = reg[nxt_rs2]
input   [31:0] dreg;               // always  dreg = reg{d_cache[ucode_addr_d]}

input          sm;                 // register scan mode
input          sin;                // register scan_input
input          reset_l;            // reset
input          clk;                // clock

output         so;                 // register scan_output

output  [31:0] u_addr_st_rd;       // ucode to stack_cache  read_address
output  [31:0] u_areg0;            // ucode output of the areg0 register
output  [31:0] ucode_porta;        // ucode output data to ie       porta
output  [31:0] ucode_portb;        // ucode output data to ie       portb
output  [31:0] ucode_portc;        // ucode output data to stcak_/data_cache

output  [31:0] ialu_a;             // ucode output data to ie_alu's porta
output  [31:0] m_adder_porta;      // ucode output data to imem_adder's porta
output  [31:0] m_adder_portb;      // ucode output data to imem_adder's portb

output  [31:0] a_oprd;             // a_oprd[31:0]
output         a_oprd_0_l;         // a_oprd[0], active low
output  [31:0] b_oprd;             // b_oprd[31:0]
output         reg5_31;            // Temp_reg5[31]


// ------------- declarations ---------------------------------------------
wire    [31:0] ucode_porta;        // ucode output data to ie       porta
wire    [31:0] ucode_portb;        // ucode output data to ie       portb
wire    [31:0] ucode_portc;        // ucode output data to stcak_/data_cache
wire    [31:0] u_addr_st_rd;       // ucode to stack_cache  read_address
wire    [31:0] u_areg0;            // ucode output of the areg0 register

wire    [31:0] ialu_a;             // ucode output data to ie_alu's porta
wire    [31:0] m_adder_porta;      // ucode output data to imem_adder's porta
wire    [31:0] m_adder_portb;      // ucode output data to imem_adder's portb

wire    [31:0] areg0;
wire    [31:0]  reg0;
wire    [31:0]  reg1;
wire    [31:0]  reg2;
wire    [31:0]  reg3;
wire    [31:0]  reg5;
wire    [31:0]  reg6;

wire    [31:0] d_areg0;
wire    [31:0] d_reg0;
wire    [31:0] d_reg1;
wire    [31:0] d_reg2;
wire    [31:0] d_reg3;
wire    [31:0] d_reg5;
wire    [31:0] d_reg6;

wire    [31:0] nxt_areg0;
wire    [31:0] nxt_reg0;
wire    [31:0] nxt_reg1;
wire    [31:0] nxt_reg2;
wire    [31:0] nxt_reg3;
wire    [31:0] nxt_reg5;
wire    [31:0] nxt_reg6;

wire    [31:0] w_mx_a,    w_mx_b0, w_mx_b1;
wire    [31:0] a_oprd,    b_oprd;  // ucode temp_reg output a,b
wire    [31:0] r236;               // reg1/2/3/6 data = ucode_portc

wire    [31:0] a_oprd_i,   a_oprd_u;
wire           a_oprd_0_l;

wire           reg_clear_l;

wire     [2:0] sel_u_f20;          // select u_f20's 8_to_1 flat_mux
wire    [31:0] const_mb;           // 8 constants for      mem_adder's portb
wire     [2:0] sel_u_f06;          // select u_f06's 8_to_1 flat_mux
wire    [31:0] const_ia;           // 8 constants for ialu_a


// W240: Unused inputs/outputs resolution
wire _unused_sm = sm;
wire _unused_sin = sin;
assign so = 1'b0; // Defaulting scan_output to 0 as it's not driven within the module


/*********** Ucode_dat section ***********************************************/

// ------------- Memory_adder operations from UCODE -----------------------
  mj_s_mux6_d_32 mux6_m_adder_porta (
                                      .mx_out(m_adder_porta[31:0]),
                                      .sel(u_f19[2:0]),
                                      .in0(dreg[31:0]),
                                      .in1({dreg[31:2],2'b0}),
                                      .in2({dreg[31:3],3'b0}),
                                      .in3(areg0[31:0]),
                                      .in4(iu_optop[31:0]),
                                      .in5(r236[31:0]) 
                                     );
 
  assign sel_u_f20 = {3{u_f20[3]}} | u_f20[2:0];
 
  mj_s_mux8_d_32 mux8_m_adder_portb (
                                      .mx_out(m_adder_portb[31:0]),
                                      .sel(sel_u_f20[2:0]),
                                      .in0(dreg[31:0]),
                                      .in1({22'b0,instr_narg, 2'b0}),
                                      .in2({22'b0,instr_index,2'b0}),
                                      .in3({14'b0,instr_indexbyte1,
                                                  instr_indexbyte2,2'b0}),
                                      .in4(r236[31:0]),
                                      .in5(32'd0),
                                      .in6(32'd1),
                                      .in7(const_mb[31:0])
                                     );
 
  assign const_mb = (u_f20 == `F20_MB_CONST_02) ? 32'd2 :
                    (u_f20 == `F20_MB_CONST_03) ? 32'd3 :
                    (u_f20 == `F20_MB_CONST_04) ? 32'd4 :
                    (u_f20 == `F20_MB_CONST_08) ? 32'd8 :
                    (u_f20 == `F20_MB_CONST_12) ? 32'd12 :
                    (u_f20 == `F20_MB_CONST_16) ? 32'd16 :
                    (u_f20 == `F20_MB_CONST_20) ? 32'd20 :
                    (u_f20 == `F20_MB_CONST_28) ? 32'd28 :
                                                 32'd2; // Default from original logic



// ------------- IU_alu       operations from UCODE -----------------------
  assign sel_u_f06 = {3{u_f06[3]}} | u_f06[2:0];
 
  mj_s_mux8_d_32 mux8_ialu_a (
                                     .mx_out(ialu_a[31:0]),
                                     .sel(sel_u_f06[2:0]),
                                     .in0(a_oprd_u[31:0]),
                                     .in1({16'b0,a_oprd_u[15:0] }),
                                     .in2({16'b0,a_oprd_u[31:16]}),
                                     .in3({a_oprd_u[30:0],1'b0}),
                                     .in4({a_oprd_u[29:0],2'b0}),
                                     .in5({a_oprd_u[28:0],3'b0}),
                                     .in6(32'd0),
                                     .in7(const_ia[31:0])
                                    );
 
  assign const_ia = (u_f06 == `F06_A_CONST_01) ? 32'd1 :
                    (u_f06 == `F06_A_CONST_02) ? 32'd2 :
                    (u_f06 == `F06_A_CONST_03) ? 32'd3 :
                    (u_f06 == `F06_A_CONST_04) ? 32'd4 :
                    (u_f06 == `F06_A_CONST_08) ? 32'd8 :
                    (u_f06 == `F06_A_CONST_12) ? 32'd12 :
                    (u_f06 == `F06_A_CONST_16) ? 32'd16 :
                    (u_f06 == `F06_A_CONST_32) ? 32'd32 :
                                                 32'd1; // Default from original logic


// ------------- 7 temp_register read/write -------------------------------
  assign reg5_31   = reg5[31];

  assign u_addr_st_rd = (u_f02[1] /*u_f02==`F02_RD_STK_REG0*/ ) ?  reg0[31:0] :
                                                                   areg0[31:0];

  buf_a_oprd buf_a_oprd_0 (
                           .a_oprd_i   (a_oprd_i[31:0]),
                           .a_oprd     (a_oprd[31:0]),
                           .a_oprd_u   (a_oprd_u[31:0]),
                           .ucode_porta(ucode_porta[31:0]),
                           .a_oprd_0_l (a_oprd_0_l)
                          );

  buf_cf_32 buf_cf_32_u_ptb ( .inp(b_oprd[31:0]), .out(ucode_portb[31:0]) );
  buf_cf_32 buf_cf_32_u_ptc ( .inp(r236[31:0]),   .out(ucode_portc[31:0]) );
  buf_cf_32 buf_cf_32_u_ar0 ( .inp(areg0[31:0]),  .out(u_areg0[31:0])     );

  mj_s_mux6_d_32 mux6_w_mx_a (
                                     .mx_out(w_mx_a[31:0]),
                                     .sel(u_f10[2:0]),
                                     .in0(alu_data[31:0]),
                                     .in1(dreg[31:0]),
                                     .in2(rs1_b[31:0]),
                                     .in3(rs2[31:0]),
                                     .in4(ucode_addr_d[31:0]),
                                     .in5(alu_data[31:0]) 
                                    );

  mj_s_mux4_d_32 mux4_w_mx_b0 (
                                      .mx_out(w_mx_b0[31:0]),
                                      .sel(u_f12[1:0]),
                                      .in0(alu_data[31:0]),
                                      .in1(rs1_b[31:0]),
                                      .in2(dreg[31:0]),
                                      .in3(rs2[31:0])
                                     );

  mj_s_mux3_d_32 mux3_w_mx_b1 (
                                      .mx_out(w_mx_b1[31:0]),
                                      .sel(u_f13[1:0]),
                                      .in0(alu_data[31:0]),
                                      .in1(d_reg0[31:0]),
                                      .in2(ucode_addr_d[31:0]) 
                                     );

  mj_s_mux8_d_32 mux8_a_oprd (
                                     .mx_out(a_oprd_i[31:0]),
                                     .sel(u_f08[2:0]),
                                     .in0(reg0[31:0]),
                                     .in1(reg1[31:0]),
                                     .in2(reg2[31:0]),
                                     .in3(reg3[31:0]),
                                     .in4(reg5[31:0]),
                                     .in5(rs1[31:0]),
                                     .in6(rs2[31:0]),
                                     .in7(dreg[31:0]) 
                                    );

  mj_s_mux8_d_32 mux8_b_oprd (
                                     .mx_out(b_oprd[31:0]),
                                     .sel(u_f09[2:0]),
                                     .in0(areg0[31:0]),
                                     .in1(reg5[31:0]),
                                     .in2(reg6[31:0]),
                                     .in3(archi_data[31:0]),
                                     .in4(rs1[31:0]),
                                     .in5(dreg[31:0]),
                                     .in6({dreg[31:2],2'b0}),
                                     .in7(dreg[31:0]) 
                                    );

  del1_32 del1_32_areg0 ( .inp(areg0[31:0]), .out(d_areg0[31:0]) );
  del1_32 del1_32_reg0  ( .inp(reg0[31:0]),  .out(d_reg0[31:0])  );
  del1_32 del1_32_reg1  ( .inp(reg1[31:0]),  .out(d_reg1[31:0])  );
  del1_32 del1_32_reg2  ( .inp(reg2[31:0]),  .out(d_reg2[31:0])  );
  del1_32 del1_32_reg3  ( .inp(reg3[31:0]),  .out(d_reg3[31:0])  );
  del1_32 del1_32_reg5  ( .inp(reg5[31:0]),  .out(d_reg5[31:0])  );
  del1_32 del1_32_reg6  ( .inp(reg6[31:0]),  .out(d_reg6[31:0])  );

  assign nxt_areg0 = (u_f15==`F15_WT_AREG0_B1) ? w_mx_b1[31:0]     : d_areg0[31:0];
  assign nxt_reg0  = (u_f11==`F11_WT_REG0_A  ) ? w_mx_a[31:0]      : d_reg0[31:0];
  assign nxt_reg1  = (u_f11==`F11_WT_REG1_A  ) ? w_mx_a[31:0]      : d_reg1[31:0];
  assign nxt_reg2  = (u_f11==`F11_WT_REG2_A  ) ? w_mx_a[31:0]      : d_reg2[31:0];
  assign nxt_reg3  = (u_f11==`F11_WT_REG3_A  ) ? w_mx_a[31:0]      : d_reg3[31:0];
  assign nxt_reg5  = (u_f14[0]/*`F14_WT_REG5_B0*/) ? w_mx_b0[31:0] : d_reg5[31:0];
  assign nxt_reg6  = (u_f14[1]/*`F14_WT_REG6_B0*/) ? w_mx_b0[31:0] : d_reg6[31:0];

  assign reg_clear_l = !(!reset_l || ie_kill_ucode);

  ff_sre_32 reg_areg0 (
                       .out(areg0[31:0]),
                       .din(nxt_areg0[31:0]),
                       .enable(!ie_stall_ucode),
                       .reset_l(reg_clear_l),
                       .clk(clk)
                      );

  ff_sre_32 reg_reg0  ( 
                       .out(reg0[31:0]),
                       .din(nxt_reg0[31:0]),
                       .enable(!ie_stall_ucode), 
                       .reset_l(reg_clear_l), 
                       .clk(clk)
                      ); 

  ff_sre_32 reg_reg1  (
                       .out(reg1[31:0]),
                       .din(nxt_reg1[31:0]),
                       .enable(!ie_stall_ucode),
                       .reset_l(reg_clear_l),
                       .clk(clk)
                      );

  ff_sre_32 reg_reg2  ( 
                       .out(reg2[31:0]),
                       .din(nxt_reg2[31:0]),
                       .enable(!ie_stall_ucode), 
                       .reset_l(reg_clear_l), 
                       .clk(clk)
                      ); 

  ff_sre_32 reg_reg3  ( 
                       .out(reg3[31:0]),
                       .din(nxt_reg3[31:0]),
                       .enable(!ie_stall_ucode), 
                       .reset_l(reg_clear_l), 
                       .clk(clk)
                      ); 

  ff_sre_32 reg_reg5  ( 
                       .out(reg5[31:0]),
                       .din(nxt_reg5[31:0]),
                       .enable(!ie_stall_ucode), 
                       .reset_l(reg_clear_l), 
                       .clk(clk)
                      ); 

  ff_sre_32 reg_reg6  ( 
                       .out(reg6[31:0]),
                       .din(nxt_reg6[31:0]),
                       .enable(!ie_stall_ucode), 
                       .reset_l(reg_clear_l), 
                       .clk(clk)
                      ); 


// ------------- Select reg2/3/6 write to data_ or stack_ cache -----------
  mj_s_mux4_d_32 mux4_r236 (
                                   .mx_out(r236[31:0]),
                                   .sel(u_f16[1:0]),
                                   .in0(reg2[31:0]),
                                   .in1(reg3[31:0]),
                                   .in2(reg6[31:0]),
                                   .in3(rs1_b[31:0]) 
                                  );

endmodule
