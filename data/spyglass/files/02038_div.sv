module div (
	clock,
	q);


	input	  clock;
	output	[0:0]  q;

	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	lpm_counter	lpm_counter_component (
				.clock (clock),
				.q (sub_wire0)
				// synopsys translate_off
				,
				.aclr (),
				.aload (),
				.aset (),
				.cin (),
				.clk_en (),
				.cnt_en (),
				.cout (),
				.data (),
				.eq (),
				.sclr (),
				.sload (),
				.sset (),
				.updown ()
				// synopsys translate_on
				);
	defparam
		lpm_counter_component.lpm_width = 1,
		lpm_counter_component.lpm_type = "LPM_COUNTER",
		lpm_counter_component.lpm_direction = "UP";


endmodule
