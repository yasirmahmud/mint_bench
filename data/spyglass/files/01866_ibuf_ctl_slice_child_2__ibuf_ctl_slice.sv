module ibuf_ctl_slice (

	valid_bits,
	dirty_bits,
	shft_dsel,
	valid_out,
	dirty_out,
	new_valid,
	icu_stall,
	fill_sel,
	ibuf_en,
	sin,
	sm,
	so,
	new_dirty,
	buf_ic_drty,
	buf_ic_valid,
	jmp_e,
	reset_l,
	clk
);

input	[6:0]	valid_bits;		// Valid bits from the following 7 buffers	-- From ibuf_ctl
input	[6:0]	dirty_bits;		// Dirty bits from the following 7 buffers	-- From ibuf_ctl
					// until Icache is accessed succesfully
input	[7:0]	shft_dsel;		// These selects will determine which of the    -- From ibuf_ctl
                                        // following 7 valid bits will be selected
					// The last bit indicates that it's a stall
input		jmp_e;
input		ibuf_en;
input		icu_stall;
output		fill_sel;
output		valid_out;		// Valid bit o/p
output		dirty_out;		// Dirty bit o/p
input		new_valid;		// Internal control signal
					// icache or follwoing 5 buffers
input		sin;			// scan input
input		sm;			// scan enable
output		so;			// scan output
input		new_dirty;			// This indicates that Icache data is dirty	-- From iu
output		buf_ic_drty;
output		buf_ic_valid;
input		reset_l;
input		clk;
	
wire	valid_in;
wire	dirty_in;

// Drive output 'so' to a default value as its function is not defined and not used in the core logic
assign so = 1'b0;

// buf_ic_valid is one if either teh current ibuffer entry is valid
// or the icache entry into the current one is valid

assign buf_ic_valid = (valid_out | new_valid&!icu_stall);
assign buf_ic_drty = (dirty_out | new_dirty&!icu_stall);

mux8  valid_mux ( .out(valid_in),
			.in0(buf_ic_valid),
			.in1(valid_bits[0]),
			.in2(valid_bits[1]),
			.in3(valid_bits[2]),
			.in4(valid_bits[3]),
			.in5(valid_bits[4]),
			.in6(valid_bits[5]),
			.in7(valid_bits[6]),
			.sel(shft_dsel)
			);

mux8  dirty_mux ( .out(dirty_in),
			.in0(buf_ic_drty),	
			.in1(dirty_bits[0]),	
			.in2(dirty_bits[1]),	
			.in3(dirty_bits[2]),	
			.in4(dirty_bits[3]),	
			.in5(dirty_bits[4]),	
			.in6(dirty_bits[5]),	
			.in7(dirty_bits[6]),	
			.sel(shft_dsel)
			);

// If shifted bit is not 1
assign	fill_sel  =  valid_out ;

mj_s_ff_snre_d  valid_flop ( .out(valid_out),
				.in(valid_in&!jmp_e),
				.clk(clk),
				.reset_l(reset_l),
				.lenable(ibuf_en)
				);

mj_s_ff_snre_d  dirty_flop ( .out(dirty_out),
				.in(dirty_in&!jmp_e),
				.clk(clk),
				.reset_l(reset_l),
				.lenable(ibuf_en)
				);

endmodule
