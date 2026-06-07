module ucode_ind (
                  opcode_2_op_r,
                  opcode_3_op_r,
                  iu_hold_e,
                  sel_wd_inc_r,
                  sel_offset_add1_r,
                  sm,
                  sin,
                  reset_l,
                  clk,
                  so,
                  index_byte1_e,
                  index_byte2_e
                 );

input    [7:0] opcode_2_op_r;      // top second byte of ibuffer of R_stage
input    [7:0] opcode_3_op_r;      // top third  byte of ibuffer of R_stage
input          iu_hold_e;          // IU unit hold E_stage information(registers)
input          sel_wd_inc_r;       // select {index_byte1,index_byte2} + 1
input          sel_offset_add1_r;  // select (offset+1) as the index_byte1,2

input          sm;                 // register scan mode
input          sin;                // register scan_input
input          reset_l;            // reset
input          clk;               // clock

output         so;                 // register scan_output

output   [7:0] index_byte1_e;      // E_stage, index_indexbyte1_offest
output   [7:0] index_byte2_e;      // E_stage, nargm_indexbyte2_offest+1

wire    [15:0] index_wd_r, inc_index_wd_r, nxt_index_wd;

  assign index_wd_r = sel_wd_inc_r ? {opcode_2_op_r[7:0],opcode_3_op_r[7:0]} :
                                     {8'b0,              opcode_2_op_r[7:0]};

/* Logic
  assign inc_index_wd_r = index_wd_r[15:0] + 16'h1;
*/

  inc16 inc16_ind ( .ai(index_wd_r[15:0]), .sum(inc_index_wd_r[15:0]) );

  assign nxt_index_wd = sel_offset_add1_r ? inc_index_wd_r[15:0] :
                                      {opcode_2_op_r[7:0],opcode_3_op_r[7:0]};


  ff_sre_16 ff_sre_16_1 (
                         .out({index_byte1_e[7:0],index_byte2_e[7:0]}),
                         .din(nxt_index_wd[15:0]),
                         .enable(!iu_hold_e),
                         .reset_l(reset_l),
                         .clk(clk)
                        );

endmodule
