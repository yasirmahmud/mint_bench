module dest_decoder (

	opcode,
	valid,
	first_cyc,
	second_cyc,
	group_2_r,
	group_3_r,
	group_5_r,
	group_6_r,
	group_7_r,
	optop_incr_sel,
	dest_we
);

input	[15:0]	opcode;
input		valid;
input		first_cyc;
input		second_cyc;
input		group_2_r;
input		group_3_r;
input		group_5_r;
input		group_6_r;
input		group_7_r;
output	[7:0]	optop_incr_sel;
output		dest_we;

wire	[15:0]	opcode_int;
wire		ext_opcode;
wire		curr_inc_optop_1;
wire		curr_inc_optop_2;
wire		curr_inc_optop_3;
wire		curr_inc_optop_4;
wire		curr_dec_optop_1;
wire		curr_no_change_optop;
wire		act_inc_optop_1;
wire		act_inc_optop_2;
wire		act_inc_optop_3;
wire		act_inc_optop_4;
wire		act_dec_optop_1;
wire		act_dec_optop_2;
wire		act_dec_optop_3;
wire		act_no_change_optop;

assign  opcode_int[15:0] = (opcode[15:0] ) & ({16{valid}});
assign	ext_opcode = (opcode_int[15:8] == 8'd255);


assign	curr_inc_optop_1 = (

		(opcode_int[15:8] == 8'd116)  |			// ineg
		(opcode_int[15:8] == 8'd118)  |			// fneg
		(opcode_int[15:8] == 8'd134)  |                 // i2f
                ((opcode_int[15:8] == 8'd135) & first_cyc)  |   // i2d
                ((opcode_int[15:8] == 8'd141) & first_cyc)  |   // f2d
                ((opcode_int[15:8] == 8'd138) & second_cyc)  |  // l2d
                (opcode_int[15:8] == 8'd139)  |                 // f2i
                ((opcode_int[15:8] == 8'd140) & first_cyc) |    // f2l
                ((opcode_int[15:8] == 8'd143) & second_cyc)  |  // d2l
                (opcode_int[15:8] == 8'd145)  |                 // i2b
                (opcode_int[15:8] == 8'd146)  |                 // i2c
                (opcode_int[15:8] == 8'd147)  |                 // i2s
		(opcode_int[15:8] == 8'd237)  | 		// sethi
		(ext_opcode & (opcode_int[7:0] == 8'd0))| 	// load_ubyte
		(ext_opcode & (opcode_int[7:0] == 8'd1))| 	// load_byte
		(ext_opcode & (opcode_int[7:0] == 8'd2))| 	// load_char
		(ext_opcode & (opcode_int[7:0] == 8'd3))| 	// load_short
		(ext_opcode & (opcode_int[7:0] == 8'd4))| 	// load_word
		(ext_opcode & (opcode_int[7:0] == 8'd6))| 	// priv_read_dcache_tag
		(ext_opcode & (opcode_int[7:0] == 8'd7))| 	// priv_read_dcache_data
		(ext_opcode & (opcode_int[7:0] == 8'd10))| 	// load_char_oe
		(ext_opcode & (opcode_int[7:0] == 8'd11))| 	// load_short_oe
		(ext_opcode & (opcode_int[7:0] == 8'd12))| 	// load_word_oe
		(ext_opcode & (opcode_int[7:0] == 8'd14)
						& first_cyc) | 	// priv_read_icache_tag
		(ext_opcode & (opcode_int[7:0] == 8'd15)
						& first_cyc) | 	// priv_read_icache_data
		(ext_opcode & (opcode_int[7:0] == 8'd16))| 	// ncload_ubyte
		(ext_opcode & (opcode_int[7:0] == 8'd17))| 	// ncload_byte
		(ext_opcode & (opcode_int[7:0] == 8'd18))| 	// ncload_char
		(ext_opcode & (opcode_int[7:0] == 8'd19))| 	// ncload_short
		(ext_opcode & (opcode_int[7:0] == 8'd20))| 	// ncload_word
		(ext_opcode & (opcode_int[7:0] == 8'd23))| 	// cache_invalidate
		(ext_opcode & (opcode_int[7:0] == 8'd26))| 	// ncload_char_oe
		(ext_opcode & (opcode_int[7:0] == 8'd27))| 	// ncload_short_oe
		(ext_opcode & (opcode_int[7:0] == 8'd28))| 	// ncload_word_oe
		(ext_opcode & (opcode_int[7:0] == 8'd30))| 	// cache_flush
		(ext_opcode & (opcode_int[7:0] == 8'd31))| 	// cache_index_flush
		((opcode_int[15:8] == 8'd117) & second_cyc) |	// lneg
		(opcode_int[15:8] == 8'd119) 			// dneg

		);

assign	curr_inc_optop_2 = (

		(opcode_int[15:8] == 8'd96)  |			// iadd
		(opcode_int[15:8] == 8'd98)  |			// fadd
		(opcode_int[15:8] == 8'd100)  |			// isub
		(opcode_int[15:8] == 8'd102)  |			// fsub
		(opcode_int[15:8] == 8'd104)  |			// imul
		(opcode_int[15:8] == 8'd106)  |			// fmul
		(opcode_int[15:8] == 8'd108)  |			// idiv
		(opcode_int[15:8] == 8'd110)  |			// fdiv
		(opcode_int[15:8] == 8'd112)  |			// irem
		(opcode_int[15:8] == 8'd114)  |			// frem
		((opcode_int[15:8] == 8'd117) & first_cyc)  |	// lneg
		(opcode_int[15:8] == 8'd120)  |			// ishl
		((opcode_int[15:8] == 8'd121) & second_cyc)  |	// lshl
		(opcode_int[15:8] == 8'd122)  |			// ishr
		((opcode_int[15:8] == 8'd123) & first_cyc)  |	// lshr
		(opcode_int[15:8] == 8'd124)  |			// iushr
		((opcode_int[15:8] == 8'd125) & first_cyc)  |	// lushr
		(opcode_int[15:8] == 8'd126)  |			// iand
		(opcode_int[15:8] == 8'd128)  |			// ior
		(opcode_int[15:8] == 8'd130)  |			// ixor
		(opcode_int[15:8] == 8'd137)  |			// l2f
		((opcode_int[15:8] == 8'd138) & first_cyc)  |	// l2d
		(opcode_int[15:8] == 8'd142)  |			// d2i
		((opcode_int[15:8] == 8'd143) & first_cyc)  |	// d2l
		(opcode_int[15:8] == 8'd144)  |			// d2f
		(opcode_int[15:8] == 8'd149)  |			// fcmpl
		(opcode_int[15:8] == 8'd150)  |			// fcmpg
		(ext_opcode & (opcode_int[7:0] == 8'd21)) 	// iucmp

	);

assign	curr_inc_optop_3 = (

   	         ((opcode_int[15:8] == 8'd97) & second_cyc)  | 	// ladd
   	         ((opcode_int[15:8] == 8'd99) & second_cyc)  | 	// dadd
   	         ((opcode_int[15:8] == 8'd101) & second_cyc) | 	// lsub
   	         ((opcode_int[15:8] == 8'd103) & second_cyc) | 	// dsub
   	         ((opcode_int[15:8] == 8'd105) & second_cyc) | 	// lmul
   	         ((opcode_int[15:8] == 8'd107) & second_cyc) | 	// dmul
   	         ((opcode_int[15:8] == 8'd109) & second_cyc) | 	// ldiv
   	         ((opcode_int[15:8] == 8'd111) & second_cyc) | 	// ddiv
   	         ((opcode_int[15:8] == 8'd113) & second_cyc) | 	// lrem
   	         ((opcode_int[15:8] == 8'd115) & second_cyc) | 	// drem
   	         ((opcode_int[15:8] == 8'd121) & first_cyc) | 	// lshl
   	         ((opcode_int[15:8] == 8'd123) & second_cyc) | 	// lshr
   	         ((opcode_int[15:8] == 8'd125) & second_cyc) | 	// lushr
   	         ((opcode_int[15:8] == 8'd127) & second_cyc) | 	// land
   	         ((opcode_int[15:8] == 8'd129) & second_cyc) | 	// lor
   	         ((opcode_int[15:8] == 8'd131) & second_cyc)  	// lxor

	);

assign	curr_inc_optop_4 = (

   	         ((opcode_int[15:8] == 8'd97) & first_cyc)  | 	// ladd
   	         ((opcode_int[15:8] == 8'd99) & first_cyc)  | 	// dadd
   	         ((opcode_int[15:8] == 8'd101) & first_cyc) | 	// lsub
   	         ((opcode_int[15:8] == 8'd103) & first_cyc) | 	// dsub
   	         ((opcode_int[15:8] == 8'd105) & first_cyc) | 	// lmul
   	         ((opcode_int[15:8] == 8'd107) & first_cyc) | 	// dmul
   	         ((opcode_int[15:8] == 8'd109) & first_cyc) | 	// ldiv
   	         ((opcode_int[15:8] == 8'd111) & first_cyc) | 	// ddiv
   	         ((opcode_int[15:8] == 8'd113) & first_cyc) | 	// lrem
   	         ((opcode_int[15:8] == 8'd115) & first_cyc) | 	// drem
   	         ((opcode_int[15:8] == 8'd127) & first_cyc) | 	// land
   	         ((opcode_int[15:8] == 8'd129) & first_cyc) | 	// lor
   	         ((opcode_int[15:8] == 8'd131) & first_cyc) |  	// lxor
   	         ((opcode_int[15:8] == 8'd148) & second_cyc) |	// lcmp
   	         ((opcode_int[15:8] == 8'd151) & second_cyc) |	// dcmpl
   	         ((opcode_int[15:8] == 8'd152) & second_cyc)   	// dcmpg
	);

assign	curr_dec_optop_1 = (

   	         ((opcode_int[15:8] == 8'd9) & second_cyc)  | 	// lconst_0
   	         ((opcode_int[15:8] == 8'd10) & second_cyc)  | 	// lconst_1
   	         ((opcode_int[15:8] == 8'd14) & second_cyc)  | 	// dconst_0
   	         ((opcode_int[15:8] == 8'd15) & second_cyc)  | 	// dconst_1
   	         ((opcode_int[15:8] == 8'd22) & second_cyc)  | 	// lload
   	         ((opcode_int[15:8] == 8'd24) & second_cyc)  | 	// dload
   	         ((opcode_int[15:8] == 8'd30) & second_cyc)  | 	// lload_0
   	         ((opcode_int[15:8] == 8'd31) & second_cyc)  | 	// lload_1
   	         ((opcode_int[15:8] == 8'd32) & second_cyc)  | 	// lload_2
   	         ((opcode_int[15:8] == 8'd33) & second_cyc)  | 	// lload_3
   	         ((opcode_int[15:8] == 8'd38) & second_cyc)  | 	// dload_0
   	         ((opcode_int[15:8] == 8'd39) & second_cyc)  | 	// dload_1
   	         ((opcode_int[15:8] == 8'd40) & second_cyc)  | 	// dload_2
   	         ((opcode_int[15:8] == 8'd41) & second_cyc)   	// dload_3
	);

assign		curr_no_change_optop = !(curr_inc_optop_1 | curr_inc_optop_2 | 
					curr_inc_optop_3 | curr_inc_optop_4 | 
					curr_dec_optop_1);

// BG2 op sometimes pushes 1 item onto stack and sometimes 2. Because of
// this it's difficult to determine the dest_offset just from group
// information. Hence we need  to decode BG2 and then use grouping
// info. to calculate the offset. For ex. for LV LB BG2 (group_3_r)
// If BG2 pushes one item onto stack, then decoding BG2 we'll get dest
// offset as +1 (it consumes 2 and pushes 1), but if we use the group info.
// (in this case group_3), then offset is -2 +1 (since 2 operands needed by
// BG2 are now available within the instruction itself  instead of popping
// them from scache. Same holds good for groups  5 and 6 (LV BG2 and LV BG1)
// for groups 2 and 7 (LV LV OP and LV OP), dest offsets are 0 and +1 resp

assign	act_inc_optop_4 = curr_inc_optop_4 & !(group_3_r | group_5_r | group_6_r);

assign	act_inc_optop_3 = curr_inc_optop_3 & !(group_3_r | group_5_r | group_6_r) |
			  curr_inc_optop_4 & (group_5_r | group_6_r);

assign	act_inc_optop_2 =  curr_inc_optop_2 &!(group_3_r | group_5_r | group_6_r) |
			    curr_inc_optop_4 & (group_3_r) |
			    curr_inc_optop_3 & (group_5_r | group_6_r);

assign	act_inc_optop_1 =  curr_inc_optop_1 &!(group_3_r | group_5_r | group_6_r) |
			    curr_inc_optop_3 & (group_3_r) |
			    curr_inc_optop_2 & (group_5_r | group_6_r);

assign	act_no_change_optop = curr_no_change_optop &!(group_3_r | group_5_r | group_6_r) |
			    curr_inc_optop_2 & (group_3_r) |
			    curr_inc_optop_1 & (group_5_r | group_6_r);

assign	act_dec_optop_1 =  curr_dec_optop_1 &!(group_3_r | group_5_r | group_6_r) |
			    curr_no_change_optop & (group_5_r | group_6_r) |
			    curr_inc_optop_1 & (group_3_r);

assign	act_dec_optop_2 =  curr_dec_optop_1 & (group_5_r | group_6_r) |
			    curr_no_change_optop & (group_3_r) ;

assign	act_dec_optop_3 =  curr_dec_optop_1 & (group_3_r );



// Instead of providing the offset, we are now providing the selects to MUXes
// to improve timing 

assign	optop_incr_sel[7] = act_inc_optop_4 & !(group_7_r | group_2_r);
assign	optop_incr_sel[6] = act_inc_optop_3 & !(group_7_r | group_2_r);
assign	optop_incr_sel[5] = act_inc_optop_2 & !(group_7_r | group_2_r);
assign	optop_incr_sel[4] = (act_inc_optop_1 | group_7_r) & !group_2_r;
assign	optop_incr_sel[3] = act_dec_optop_1 & !(group_7_r | group_2_r);
assign	optop_incr_sel[2] = act_dec_optop_2 & !(group_7_r | group_2_r);
assign	optop_incr_sel[1] = act_dec_optop_3 & !(group_7_r | group_2_r);
assign	optop_incr_sel[0] = !(|optop_incr_sel[7:1]); 
			

/*
mux8_32		mux_dest_offset_int (.out(dest_offset_int),
				.in0(32'h0),
				.in1(32'hfffffff4),	// 2's complement of 4*-3
				.in2(32'hfffffff8),	// 2's complement of 4*-2
				.in3(32'hfffffffc),	// 2's complement of 4*-1
				.in4(32'h4),		// 4*1
				.in5(32'h8),		// 4*2
				.in6(32'hc),		// 4*3
				.in7(32'h10),		// 4*4
				.sel({
					act_inc_optop_4,
					act_inc_optop_3,
					act_inc_optop_2,
					act_inc_optop_1,
					act_dec_optop_1,
					act_dec_optop_2,
					act_dec_optop_3,
					(default_ch_optop | act_no_change_optop) 
				     }) );
				    
mux3_32		mux_dest_offset(.out(dest_offset),
				.in0(dest_offset_int),
				.in1(32'h0),
				.in2(32'h4),
				.sel ( {
					group_7_r,
					group_2_r,
					!(group_7_r | group_2_r)
					}) );
*/

assign	dest_we	= (

		(opcode_int[15:8] == 8'd1) |			// aconst_null
		(opcode_int[15:8] == 8'd2) |			// iconst_m1
		(opcode_int[15:8] == 8'd3) |			// iconst_0
		(opcode_int[15:8] == 8'd4) |			// iconst_1
		(opcode_int[15:8] == 8'd5) |			// iconst_2
		(opcode_int[15:8] == 8'd6) |			// iconst_3
		(opcode_int[15:8] == 8'd7) |			// iconst_4
		(opcode_int[15:8] == 8'd8) |			// iconst_5
		(opcode_int[15:8] == 8'd9) |			// lconst_0
		(opcode_int[15:8] == 8'd10) |			// lconst_1
		(opcode_int[15:8] == 8'd11) |			// fconst_0
		(opcode_int[15:8] == 8'd12) |			// fconst_1
		(opcode_int[15:8] == 8'd13) |			// fconst_2
		(opcode_int[15:8] == 8'd14) |			// dconst_0
		(opcode_int[15:8] == 8'd15) |			// dconst_1
		(opcode_int[15:8] == 8'd16) |			// bipush
		(opcode_int[15:8] == 8'd17) |			// sipush
		(opcode_int[15:8] == 8'd21) |			// iload
		(opcode_int[15:8] == 8'd22) |			// lload
		(opcode_int[15:8] == 8'd23) |			// fload
		(opcode_int[15:8] == 8'd24) |			// dload
		(opcode_int[15:8] == 8'd25) |			// aload
		(opcode_int[15:8] == 8'd26) |			// iload_0
		(opcode_int[15:8] == 8'd27) |			// iload_1
		(opcode_int[15:8] == 8'd28) |			// iload_2
		(opcode_int[15:8] == 8'd29) |			// iload_3
		(opcode_int[15:8] == 8'd30) |			// lload_0
		(opcode_int[15:8] == 8'd31) |			// lload_1
		(opcode_int[15:8] == 8'd32) |			// lload_2
		(opcode_int[15:8] == 8'd33) |			// lload_3
		(opcode_int[15:8] == 8'd34) |			// fload_0
		(opcode_int[15:8] == 8'd35) |			// fload_1
		(opcode_int[15:8] == 8'd36) |			// fload_2
		(opcode_int[15:8] == 8'd37) |			// fload_3
		(opcode_int[15:8] == 8'd38) |			// dload_0
		(opcode_int[15:8] == 8'd39) |			// dload_1
		(opcode_int[15:8] == 8'd40) |			// dload_2
		(opcode_int[15:8] == 8'd41) |			// dload_3
		(opcode_int[15:8] == 8'd42) |			// aload_0
		(opcode_int[15:8] == 8'd43) |			// aload_1
		(opcode_int[15:8] == 8'd44) |			// aload_2
		(opcode_int[15:8] == 8'd45) |			// aload_3
		(opcode_int[15:8] == 8'd89) |			// dup
		(opcode_int[15:8] == 8'd96) |			// iadd
		(opcode_int[15:8] == 8'd97) |			// ladd
		(opcode_int[15:8] == 8'd98) |			// fadd
		(opcode_int[15:8] == 8'd99) |			// dadd
		(opcode_int[15:8] == 8'd100) |			// isub
		(opcode_int[15:8] == 8'd101) |			// lsub
		(opcode_int[15:8] == 8'd102) |			// fsub
		(opcode_int[15:8] == 8'd103) |			// dsub
		(opcode_int[15:8] == 8'd104) |			// imul
		(opcode_int[15:8] == 8'd106) |			// fmul
		(opcode_int[15:8] == 8'd107) |			// dmul
		(opcode_int[15:8] == 8'd108) |			// idiv
		(opcode_int[15:8] == 8'd110) |			// fdiv
		(opcode_int[15:8] == 8'd111) |			// ddiv
		(opcode_int[15:8] == 8'd112) |			// irem
		(opcode_int[15:8] == 8'd114) |			// frem
		(opcode_int[15:8] == 8'd115) |			// drem
		(opcode_int[15:8] == 8'd116) |			// ineg
		(opcode_int[15:8] == 8'd117) |			// lneg
		(opcode_int[15:8] == 8'd118) |			// fneg
		(opcode_int[15:8] == 8'd119) |			// dneg
		(opcode_int[15:8] == 8'd120) |			// ishl
		(opcode_int[15:8] == 8'd121) |			// lshl
		(opcode_int[15:8] == 8'd122) |			// ishr
		(opcode_int[15:8] == 8'd123) |			// lshr
		(opcode_int[15:8] == 8'd124) |			// iushr
		(opcode_int[15:8] == 8'd125) |			// lushr
		(opcode_int[15:8] == 8'd126) |			// iand
		(opcode_int[15:8] == 8'd127) |			// iand
		(opcode_int[15:8] == 8'd128) |			// ior
		(opcode_int[15:8] == 8'd129) |			// ior
		(opcode_int[15:8] == 8'd130) |			// ixor
		(opcode_int[15:8] == 8'd131) |			// ixor
		(opcode_int[15:8] == 8'd132) |			// iinc
		(opcode_int[15:8] == 8'd133) |			// i2l
		(opcode_int[15:8] == 8'd134) |			// i2f
		(opcode_int[15:8] == 8'd135) |			// i2d
		(opcode_int[15:8] == 8'd137) |			// l2f
		(opcode_int[15:8] == 8'd138) |			// l2d
		(opcode_int[15:8] == 8'd139) |			// f2i
		(opcode_int[15:8] == 8'd140) |			// f2l
		(opcode_int[15:8] == 8'd141) |			// f2d
		(opcode_int[15:8] == 8'd142) |			// d2i
		(opcode_int[15:8] == 8'd143) |			// d2l
		(opcode_int[15:8] == 8'd144) |			// d2f
		(opcode_int[15:8] == 8'd145) |			// i2b
		(opcode_int[15:8] == 8'd146) |			// i2c
		(opcode_int[15:8] == 8'd147) |			// i2s
		((opcode_int[15:8] == 8'd148) & second_cyc) |	// lcmp
		(opcode_int[15:8] == 8'd149) |			// fcmpl
		(opcode_int[15:8] == 8'd150) |			// fcmpg
		((opcode_int[15:8] == 8'd151) & second_cyc) |	// dcmpl
		((opcode_int[15:8] == 8'd152) & second_cyc) |	// dcmpg
		(opcode_int[15:8] == 8'd168) |			// jsr
		(opcode_int[15:8] == 8'd201) |			// jsr_w
		(opcode_int[15:8] == 8'd237) |			// sethi
		(opcode_int[15:8] == 8'd238) |			// load_word_index
		(opcode_int[15:8] == 8'd239) |			// load_short_index
		(opcode_int[15:8] == 8'd240) |			// load_char_index
		(opcode_int[15:8] == 8'd241) |			// load_byte_index
		(opcode_int[15:8] == 8'd242) |			// load_ubyte_index
		(ext_opcode & (opcode_int[7:0] == 8'd0))| 	// load_ubyte
		(ext_opcode & (opcode_int[7:0] == 8'd1))| 	// load_byte
		(ext_opcode & (opcode_int[7:0] == 8'd2))| 	// load_char
		(ext_opcode & (opcode_int[7:0] == 8'd3))| 	// load_short
		(ext_opcode & (opcode_int[7:0] == 8'd4))| 	// load_word
		(ext_opcode & (opcode_int[7:0] == 8'd6))| 	// priv_read_dcache_tag
		(ext_opcode & (opcode_int[7:0] == 8'd7))| 	// priv_read_dcache_data
		(ext_opcode & (opcode_int[7:0] == 8'd10))| 	// load_char_oe
		(ext_opcode & (opcode_int[7:0] == 8'd11))| 	// load_short_oe
		(ext_opcode & (opcode_int[7:0] == 8'd12))| 	// load_word_oe
		(ext_opcode & (opcode_int[7:0] == 8'd14) 
						& first_cyc) | 	// priv_read_icache_tag
		(ext_opcode & (opcode_int[7:0] == 8'd15) 
						& first_cyc) | 	// priv_read_icache_data
		(ext_opcode & (opcode_int[7:0] == 8'd16))| 	// ncload_ubyte
		(ext_opcode & (opcode_int[7:0] == 8'd17))| 	// ncload_byte
		(ext_opcode & (opcode_int[7:0] == 8'd18))| 	// ncload_char
		(ext_opcode & (opcode_int[7:0] == 8'd19))| 	// ncload_short
		(ext_opcode & (opcode_int[7:0] == 8'd20))| 	// ncload_word
		(ext_opcode & (opcode_int[7:0] == 8'd21))| 	// iucmp
		(ext_opcode & (opcode_int[7:0] == 8'd23))| 	// cache_invalidate
		(ext_opcode & (opcode_int[7:0] == 8'd26))| 	// ncload_char_oe
		(ext_opcode & (opcode_int[7:0] == 8'd27))| 	// ncload_short_oe
		(ext_opcode & (opcode_int[7:0] == 8'd28))| 	// ncload_word_oe
		(ext_opcode & (opcode_int[7:0] == 8'd30))| 	// cache_flush
		(ext_opcode & (opcode_int[7:0] == 8'd31))| 	// cache_index_flush
		(ext_opcode & (opcode_int[7:0] == 8'd64))| 	// read_pc
		(ext_opcode & (opcode_int[7:0] == 8'd65))| 	// read_vars
		(ext_opcode & (opcode_int[7:0] == 8'd66))| 	// read_frame
		(ext_opcode & (opcode_int[7:0] == 8'd67))| 	// read_optop
		(ext_opcode & (opcode_int[7:0] == 8'd68))| 	// priv_read_oplim
		(ext_opcode & (opcode_int[7:0] == 8'd69))| 	// read_const_pool
		(ext_opcode & (opcode_int[7:0] == 8'd70))| 	// priv_read_psr
		(ext_opcode & (opcode_int[7:0] == 8'd71))| 	// priv_read_trapbase
		(ext_opcode & (opcode_int[7:0] == 8'd72))| 	// priv_read_lockcount0
		(ext_opcode & (opcode_int[7:0] == 8'd73))| 	// priv_read_lockcount1
		(ext_opcode & (opcode_int[7:0] == 8'd76))| 	// priv_read_lockaddr0
		(ext_opcode & (opcode_int[7:0] == 8'd77))| 	// priv_read_lockaddr1
		(ext_opcode & (opcode_int[7:0] == 8'd80))| 	// priv_read_userrange1
		(ext_opcode & (opcode_int[7:0] == 8'd81))| 	// priv_read_gc_config
		(ext_opcode & (opcode_int[7:0] == 8'd82))| 	// priv_read_brk1a
		(ext_opcode & (opcode_int[7:0] == 8'd83))| 	// priv_read_brk2a
		(ext_opcode & (opcode_int[7:0] == 8'd84))| 	// priv_read_brk12c
		(ext_opcode & (opcode_int[7:0] == 8'd85))| 	// priv_read_userrange2
		(ext_opcode & (opcode_int[7:0] == 8'd87))| 	// priv_read_versionid
		(ext_opcode & (opcode_int[7:0] == 8'd88))| 	// priv_read_hcr
		(ext_opcode & (opcode_int[7:0] == 8'd89))| 	// priv_read_sc_bottom
		(ext_opcode & (opcode_int[7:0] == 8'd90))| 	// read_global0
		(ext_opcode & (opcode_int[7:0] == 8'd91))| 	// read_global1
		(ext_opcode & (opcode_int[7:0] == 8'd92))| 	// read_global2
		(ext_opcode & (opcode_int[7:0] == 8'd93)) 	// read_global3

	);
endmodule
