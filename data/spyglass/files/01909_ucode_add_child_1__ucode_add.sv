module ucode_add (
                  opcode_1_op_r,
                  opcode_2_op_r,
                  valid_op_r,
                  iu_trap_r,
                  nxt_addr_1,
                  nxt_addr_2,
                  nxt_addr_3,
                  u_f18_6,
                  u_f18_5,
                  u_f08_rd_rs1_a,
                  rs1_0_l,
                  rs2_0_l,
                  u_done_l,
                  rom_addr,
                  rom_addr_l,
                  ucode_in_r,
                  sel_wd_inc_r,
                  sel_offset_add1_r
                 );

//  `include  "../../../common/ucode.h"

input    [7:0] opcode_1_op_r;      // top first  byte of ibuffer of R_stage
input    [7:0] opcode_2_op_r;      // top second byte of ibuffer of R_stage
input          valid_op_r;         // the opcode is valid        of R_stage
input          iu_trap_r;          // IU issue trap operation    of R_stage

input    [8:0] nxt_addr_1;         // ucode calculated rom_addr + 1        
input    [8:0] nxt_addr_2;         // ucode calculated rom_addr + 2        
input    [8:0] nxt_addr_3;         // ucode calculated rom_addr + 3        
input          u_f18_6;            // field_18: Branching in ucode, bit[6]
input          u_f18_5;            // field_18: Branching in ucode, bit[5]
input          u_f08_rd_rs1_a;     // Field_08: Read_port_A of RS1
input          rs1_0_l;            // rs1[0], active low, from IU
input          rs2_0_l;            // rs2[0], active low, from IU
input          u_done_l;           // the ucode is done, active low

output   [8:0] rom_addr;           // next_state of the ucode sequencer
output   [8:0] rom_addr_l;         // next_state of the ucode sequencer, active low
output         ucode_in_r;         // valid ucode opcode         of R_stage
output         sel_wd_inc_r;       // select {index_byte1,index_byte2} + 1
output         sel_offset_add1_r;  // select (offset+1) as the offset

wire     [8:0] next_addr;          // ucode calculated rom_addr  of E_stage
wire     [8:0] rom_addr;           // next_state of the ucode sequencer
wire     [8:0] rom_addr_l;         // next_state of the ucode sequencer, active low
wire           bit1, bit0;

// --- Start: Inlined logic for branch_bit module (resolves ErrorAnalyzeBBox for branch_bit) ---
wire rsx_0_l;           // rs1_0_l or rs2_0_l, active low
wire a_oprd_0;          // Positive logic version of rsx_0_l
wire check_handle2;     // Represents jump_2 condition
wire check_handle;      // Represents jump_3, [0]=0 condition
wire check_handle_p;    // Represents jump_3, [0]=1 condition

assign rsx_0_l         = u_f08_rd_rs1_a ? rs1_0_l : rs2_0_l;
assign a_oprd_0        = !rsx_0_l; // Convert active low rsx_0_l to active high a_oprd_0

assign check_handle2   = (!u_f18_6  &&  u_f18_5);  // jump_2
assign check_handle    = ( u_f18_6  && !u_f18_5);  // jump_3, [0]=0
assign check_handle_p  = ( u_f18_6  &&  u_f18_5);  // jump_3, [0]=1

assign bit1 = (check_handle   && !a_oprd_0) || 
              (check_handle_p &&  a_oprd_0) ||
              (check_handle2  &&  a_oprd_0); 
 
assign bit0 = (check_handle   && !a_oprd_0) ||
              (check_handle_p &&  a_oprd_0) || 
             !(check_handle2  &&  a_oprd_0);
// --- End: Inlined logic for branch_bit module ---


// --- Start: Inlined logic for mx3_9 module (resolves ErrorAnalyzeBBox for mx3_9) ---
assign next_addr = ({bit1,bit0} == 2'h2) ? nxt_addr_2[8:0] :
                   (({bit1,bit0} == 2'h3) ? nxt_addr_3[8:0] : nxt_addr_1[8:0]);
// --- End: Inlined logic for mx3_9 module ---


  assign rom_addr_l = ~rom_addr[8:0];

  ucode_dec ucode_dec_0 (
                         .opcode_1_op_r(opcode_1_op_r[7:0]),
                         .opcode_2_op_r(opcode_2_op_r[7:0]),
                         .valid_op_r   (valid_op_r),
                         .iu_trap_r    (iu_trap_r),
                         .next_addr    (next_addr[8:0]),
                         .u_done_l     (u_done_l),
                         .rom_addr         (rom_addr[8:0]),
                         .ucode_in_r       (ucode_in_r),
                         .sel_wd_inc_r     (sel_wd_inc_r),
                         .sel_offset_add1_r(sel_offset_add1_r)
                        );

endmodule
