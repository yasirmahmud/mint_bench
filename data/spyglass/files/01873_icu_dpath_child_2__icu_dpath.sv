`define it_addr_msb 31 // MSB of the tag address region (e.g., icu_addr[31] if index starts at 12)
`define ic_msb 11      // MSB of the cache index region (e.g., icu_addr[11] if index is [11:4])
`define it_msb 19      // MSB of the actual tag data (e.g., itag_dout[19] if tag is 20 bits wide)

module icu_dpath (
	iu_addr_e,
	misc_din,
	iu_br_pc,
	icu_addr,
	icu_dout_d,
	ibuf_oplen,
	icu_pc_d,
	addr_reg_sel,
	addr_reg_enable,
	icu_addr_sel,
        biu_addr_sel,
	ic_data_sel,
	valid,
	icu_tag_sel,
	ibuf_pc_sel,
	encod_shift_e,
	next_addr_sel,
	icu_hit,
	latch_biu_addr,
	itag_dout,
	itag_vld,
	icu_din,
	icu_tag_in,
	icram_dout,
	icu_biu_addr,
	biu_data,
	clk,
	reset_l,
	sin,
	sm,
	so,
	misc_dout,
        diag_ld_cache_c,
        icram_powerdown,
	ibuf_enable,
  	next_fetch_inc,
	ic_dout_sel,
	iu_shift_d,
	icu_addr_2_0,
	iu_psr_bm8,
	fill_word_addr,
	icu_bypass_q,
 	misc_wrd_sel,
        ic_hit,
	ice_line_align,
	bypass_ack
	);
	

input	[31:0]		iu_addr_e;		// Address from IU
input	[31:0]		misc_din ;		// Diagnostic data input
input	[31:0]		iu_br_pc ;		// addr to jump on branch taken 
input	[15:0]		valid ;
input	[63:0]		icram_dout ;		// Data out of the icache ram.
output	[`it_addr_msb:`ic_msb+1]  icu_tag_in;	// Data input to the tag ram
output	[31:0]		icu_addr;		// Address of data to be accessed in cache next cycle
output	[55:0]		icu_dout_d;		// First 5 bytes of the ibuffer
output  [27:0]  	ibuf_oplen;             // opcode length from ibuffer
output	[31:0]		icu_pc_d;		// PC of the 1 byte of the ibuffer
input	[1:0]		addr_reg_sel;		// used to latch current I$ addr.to determine next fetch
input			addr_reg_enable;		// used to latch current I$ addr.to determine next fetch
input	[1:0]		icu_addr_sel;		// select Addr to be indexed into rams. 
input	[1:0]		biu_addr_sel;		 
input			ic_data_sel;		// select data input to icram 
input			icu_tag_sel;		// select input to tag ram
input	[11:0]		ic_dout_sel;		// selects for the ibuffer
input	[1:0]		ibuf_pc_sel;		// select pc input in ibuffer
input	[2:0]		encod_shift_e;		// encoded select used to calculate next pc_d
input	[7:0]		iu_shift_d;		// shifter selects for the ibuffer
input	[3:0]		next_addr_sel;		// select addr input to icram
input			reset_l;
output			icu_hit;		// cache hit in set 0
input			latch_biu_addr;		// cache miss
input	[`it_msb:0]	itag_dout;		// Data out of the Tag 
input			itag_vld;		// Tag data is valid
output	[31:0]		icu_din;		// Data into the Instruction RAM
output	[31:0]		icu_biu_addr;		// Address to the BIU
input	[31:0]		biu_data;		// Data from the BIU
input			clk;			// clock
input			sin;			// scan data input
input			sm;			// scan enable
output			so;			// scan data output
output	[31:0]		misc_dout;		// Diagnostic data output
input			diag_ld_cache_c;	// Diagnostic rd to ram
input			ibuf_enable;		//
input   [3:0]		next_fetch_inc;		// next_fetch_inc = 1, if 8 bit
						// next_fetch_inc = 4, if bypass 
						// next_fetch_inc = 8, if cache_hit 
input                   icram_powerdown;        // powerdown signal to RAM and TAG

input			ic_hit;			// tag compare result
input			iu_psr_bm8;
input  [1:0]		fill_word_addr;
input			icu_bypass_q;
output  [2:0]           icu_addr_2_0;           // bits 2:0 of icu_addr bus     
output			misc_wrd_sel;
output			ice_line_align;
input			bypass_ack;

wire	[3:0]		icu_addr_qw_align_int;
wire 			icram_powerdown;
wire    [31:0]          next_addr;
wire	[31:0]		icu_addr_d1;
wire	[31:0]		icu_addr_qw_align;
wire	[31:0]		biu_addr;
wire    [31:0] 		icu_fill_addr;
wire	[63:0]		align_data;
wire  	[1:0]           icu_addr_offset;        // icu_addr_offset to IBUF is set
                                                // to be byte addressable,
                                                // if iu_psr_bm8 is asserted.
wire  	[1:0]           biu_addr_offset;	// biu_addr_offset to BIU is set
                                        	// to be byte addressable,
                                        	// if iu_psr_bm8 is asserted.
wire 	[31:0] 		encode_oplen;

// Two sets of addr_offsets, one for buffer alignment,
// another for BIU word alignment.

assign  icu_addr_2_0[2:0] = icu_addr_d1[2:0] ;

assign icu_addr_offset = (iu_psr_bm8)? icu_addr_2_0[1:0]: 2'b00;

assign biu_addr_offset = (iu_psr_bm8)? biu_addr[1:0]: 2'b00;

wire	[31:0]	addr_reg_data;
wire	[31:0]	next_fetch;
// Address Datapath

// Address sent to memory on cache misses
// even if the requested data may not be word aligned, requests to memory
// are word aligned. The aligner in the datapath will align depending the
// lower two bits of the address.
 
mux4_32 next_addr_mux ( .out(next_addr[31:0]), 
			.in3(icu_fill_addr[31:0]),	// cache miss
			.in2(iu_addr_e[31:0]),		// diagnostic access
			.in1(icu_addr_d1),		// stall
			.in0(next_fetch[31:0]),		// next sequential fetch
			.sel(next_addr_sel[3:0])
			);

mux2_32  icu_addr_mux ( .out(icu_addr[31:0]),
		        .in1(iu_br_pc[31:0]),		// on a branch
		        .in0(next_addr[31:0]), 		// next sequential fetch
		        .sel({icu_addr_sel[1],1'b0})
				);
mux2_32 addr_reg_mux ( .out(addr_reg_data[31:0]),
                        .in1(iu_br_pc[31:0]),          // branch
                        .in0(next_fetch[31:0]),        // next sequential fetch
                        .sel({addr_reg_sel[1],1'b0})
                        );

mux2_4   biu_addr_mux (	.out(icu_addr_qw_align_int[3:0]),
				.in1(4'b0),
				.in0(icu_addr_d1[3:0]),
				.sel({biu_addr_sel[1],1'b0})
				);

assign	icu_addr_qw_align = {icu_addr_d1[31:4],icu_addr_qw_align_int[3:0]};


// Used to latch nextfetch addr in case of ibufferfull or diagnostic rd/wr
// Also latch branch/trap address if they occur inbetn a cache miss transaction

ff_sre_32 icu_addr_d1_reg 	(.out(icu_addr_d1[31:0]),
					.din(addr_reg_data[31:0]),
					.clk(clk),
					.enable(addr_reg_enable),
					.reset_l(reset_l)
					);

// Latch fill address

assign	icu_fill_addr[31:0]	= {biu_addr[31:4],fill_word_addr[1:0],2'b0};

// Latch biu address

ff_sre_32 biu_addr_reg (	.out(biu_addr[31:0]),
				        .din(icu_addr_qw_align[31:0]),
				        .enable(!latch_biu_addr),
					.reset_l(reset_l),
				        .clk(clk)
					);

assign icu_biu_addr[31:0] = {biu_addr[31:2],biu_addr_offset} ;

assign ice_line_align = (icu_addr_d1[3:0] == 4'h0);

// Generate Next fetch Address 
// Fetch the next word if it is NC access
// Fetch one byte in case of 8bit mode
// Fetch one two words if it cache hit access


cla_adder_32    next_fetch_adder(
                .in1({icu_addr_d1[31:3],!next_fetch_inc[3] & icu_addr_d1[2], icu_addr_offset}),
                .in2({8'b00000000,8'b00000000,8'b00000000,4'b0000,next_fetch_inc}),
                .cin(1'b0),
                .sum(next_fetch),
                .cout()
);



// Data input to the Tag Ram
// select MAR reg for tag input in case of cache misses and
// select icu_data in case of diagnostic writes to icache tag

// replaced behavorial coded mux with an instantiated mux
assign icu_tag_in[`it_addr_msb:`ic_msb+1] = (icu_tag_sel)?icu_addr[`it_addr_msb:`ic_msb+1]:misc_din[`it_addr_msb:`ic_msb+1];

// Generation of icram_pwdn_d1
// !icram_powerdown is sampled by synchronous itag ram, so 
// it takes on tick to change itag_vld from unknown state(powerdown mode)
// to a valid state. To avoid icu_hit being X, a delayed icram_powerdown
// is used to negate it.
// 
// Note:
// itag_vld's state during powerdown mode depends on the silicon implementation
// This is why we model it as "X" during powerdown mode, our "X' means it can 
// be "1 ,or "0", or floating. 
// If can make sure itag_vld remains at solid "0", during 
// powerdown mode then they have an option to remove icram_pwdn_d1 to save 
// one flip-flop.  
  
wire icram_pwdn_d1; 

mj_s_ff_s_d  icram_pwdn_reg ( .out(icram_pwdn_d1),
                               	.in(icram_powerdown),
                               	.clk(clk)
				);


// The new ic_hit from itag.v has logically changed to (ic_hit & itag_vld)
assign icu_hit = ic_hit & !icram_powerdown & !icram_pwdn_d1;

assign misc_wrd_sel = icu_addr[2];

wire   misc_wrd_sel_d1;

mj_s_ff_snr_d  misc_wrd_se_reg ( .out(misc_wrd_sel_d1),
	                        	.clk(clk),
	                        	.in(misc_wrd_sel),
	                        	.reset_l(reset_l)
					);

/*******      Data  Path	******/

// replaced behavorial coded mux with an instantiated mux
// assign	icu_din = (ic_data_sel)? biu_data[31:0]:misc_din[31:0];

mux2_32 icu_din_mux ( .out(icu_din[31:0]), 
			.in1(biu_data[31:0]), 
			.in0(misc_din[31:0]), 
			.sel({ic_data_sel,1'b0})
			);

// replaced behavorial coded mux with an instantiated mux
// wire    [31:0] misc_out_temp = misc_wrd_sel_d1? icram_dout[31:0]:icram_dout[63:32]; 

wire [31:0]  misc_out_temp;

mux2_32 misc_out_temp_mux ( .out(misc_out_temp[31:0]), 
				.in1(icram_dout[31:0]), 
				.in0(icram_dout[63:32]), 
				.sel({misc_wrd_sel_d1,1'b0})
				);

// replaced behavorial coded mux with an instantiated mux
//assign	misc_dout = (diag_ld_cache_c)? misc_out_temp:
//                    {itag_dout[`it_msb:0],{(30-`it_msb){1'b0}},itag_vld};

wire	[`it_addr_msb+2:0]	misc_in_tmp;
wire	[31:0]			misc_in;

// The original behavioral assignment for misc_dout when !diag_ld_cache_c formed a 32-bit value.
// With the current macro definitions (`it_addr_msb=31`, `it_msb=19`):
// The expression {2'b00,itag_dout[`it_msb:0],{(`it_addr_msb-`it_msb-1){1'b0}},itag_vld} evaluates to:
// {2'b00, itag_dout[19:0], {11{1'b0}}, itag_vld}, which is 34 bits wide. 
// Assigning misc_in[31:0] = misc_in_tmp[31:0] truncates the two most significant bits (2'b00) 
// This makes misc_in[31:0] equivalent to {itag_dout[19:0], {11{1'b0}}, itag_vld}, matching the original 32-bit output logic.
assign misc_in_tmp[`it_addr_msb+2:0] = {2'b00,itag_dout[`it_msb:0],{(`it_addr_msb-`it_msb-1){1'b0}},itag_vld};
assign misc_in[31:0] = misc_in_tmp[31:0];

mux2_32 misc_dout_mux ( .out(misc_dout[31:0]), 
			.in1(misc_out_temp[31:0]), 
			.in0(misc_in[31:0]), 
			.sel({diag_ld_cache_c,1'b0})
			);

// Bypass register to latch biu_data 
 
wire [31:0] biu_din_q;

// replaced behavorial coded mux with an instantiated mux
// wire [31:0] biu_data_in = bypass_ack? biu_data: biu_din_q;

wire [31:0] biu_data_in;

mux2_32 bypass_ack_mux ( .out(biu_data_in), 
				.in1(biu_data), 
				.in0(biu_din_q), 
				.sel({bypass_ack,1'b0})
				);

mj_s_ff_s_d_32 icu_din_reg ( .out(biu_din_q[31:0]), 
			        .din(biu_data_in[31:0]),   
			        .clk(clk)
				);

// Aligner -- align data out of cache 

ic_aligner		ic_aligner(
				   .bypass_nalgn_dina(biu_din_q[31:0]),
                                   .icache_nalgn_dinb(icram_dout[63:0]),
				   .dout(align_data[63:0]),
                                   .sel({iu_psr_bm8,icu_addr_2_0[2:0]}),
			           .bypass(icu_bypass_q));

ic_len_decoder opcode_len_encode_0(.opcode(align_data[63:56]), .len(encode_oplen[31:28]));
ic_len_decoder opcode_len_encode_1(.opcode(align_data[55:48]), .len(encode_oplen[27:24]));
ic_len_decoder opcode_len_encode_2(.opcode(align_data[47:40]), .len(encode_oplen[23:20]));
ic_len_decoder opcode_len_encode_3(.opcode(align_data[39:32]), .len(encode_oplen[19:16]));
ic_len_decoder opcode_len_encode_4(.opcode(align_data[31:24]), .len(encode_oplen[15:12]));
ic_len_decoder opcode_len_encode_5(.opcode(align_data[23:16]), .len(encode_oplen[11:8]));
ic_len_decoder opcode_len_encode_6(.opcode(align_data[15:8]), .len(encode_oplen[7:4]));
ic_len_decoder opcode_len_encode_7(.opcode(align_data[7:0]), .len(encode_oplen[3:0]));


ibuffer			ibuffer (
				.ibuf_dout	(icu_dout_d[55:0]),
				.ibuf_oplen     (ibuf_oplen[27:0]),
				.icache_data	(align_data[63:0]),
			        .encode_oplen   (encode_oplen[31:0]),	
				.shft_dsel	(iu_shift_d[7:0]),
				.nxt_ibuf_pc	(icu_pc_d[31:0]),
				.encod_dsel	(encod_shift_e[2:0]),
				.ibuf_enable	(ibuf_enable),
				.buf_ic_sel	(valid),
				.jmp_pc		(icu_addr_d1[31:0]),
				.ibuf_pc_sel	(ibuf_pc_sel[1:0]),
				.ic_sel		(ic_dout_sel[11:0]),
				.sin		(sin), // Connect top-level input 'sin'
				.sm		(sm),  // Connect top-level input 'sm'
				.so		(so),  // Connect top-level output 'so'
				.reset_l	(reset_l),
				.clk		(clk));
				
endmodule
