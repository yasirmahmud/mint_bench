module tx_bit1_phy #(
	parameter	PHASE	= 0,
	parameter	ACTIVE	= 0
)(
	//-->> SPI INTERFACE <<---
	input		sck				,
	input		cs_n        		,
	output		miso        		,
	//--<< SPI INTERFACE >>---
	input		clock     			,
	input		rst_n                   ,
	input		tx_data                 ,
	input		tx_valid                ,
	output		can_ref_new_data		,
	output [23:0]	trigger_cnt			,
	output		idle
);

// --- START FIX FOR SPYGLASS VIOLATION ---
// The original 'trigger_clock' was combinatorially derived using 'cs_n' in some modes
// while 'cs_n' (via 'trigger_rst_n') also served as an asynchronous reset for flops
// clocked by 'trigger_clock'. This dual role for 'cs_n' causes STAR C05-1.3.1.3 violation.
// To fix, we decompose 'trigger_clock' into an ungated base clock and a clock enable signal.
// Registers will now be clocked by the 'trigger_base_clock_sig' and gated by 'trigger_clock_enable_sig',
// effectively replicating the original gated clock behavior without 'cs_n' directly in the clock path.

wire trigger_base_clock_sig;     // Clock source dependent only on sck and PHASE
wire trigger_clock_enable_sig;   // Enable signal dependent on cs_n and ACTIVE

// Determine the base clock (sck or !sck) based on PHASE parameter
always@(*) begin
    case(PHASE)
        1'b0: trigger_base_clock_sig = !sck;
        1'b1: trigger_base_clock_sig = sck;
        default: trigger_base_clock_sig = 1'b0; // Should not be reached for 1-bit param
    endcase
end

// Determine the clock enable based on ACTIVE and cs_n
always@(*) begin
    case(ACTIVE)
        1'b0: trigger_clock_enable_sig = !cs_n; // Clock enabled only when cs_n is active low
        1'b1: trigger_clock_enable_sig = 1'b1;  // Clock always enabled if ACTIVE is 1
        default: trigger_clock_enable_sig = 1'b0; // Should not be reached for 1-bit param
    endcase
end
// --- END FIX FOR SPYGLASS VIOLATION ---

// Original 'trigger_clock' logic removed. Registers will now use the new signals.

reg		trigger_rst_n;
always@(cs_n)
	trigger_rst_n	= ~cs_n;

reg 	trigger_flag;
reg		write_flag;

reg		wr_data;
reg		tri_data;

always@(posedge clock,negedge rst_n)
	if(~rst_n)	wr_data	<= 1'b0;
	else		wr_data	<= tx_valid? tx_data : wr_data;

always@(posedge clock,negedge rst_n)
	if(~rst_n)	write_flag	<= 1'b0;
	else if(!cs_n)
				write_flag	<= tx_valid? ~write_flag : write_flag;
	else		write_flag	<= ~trigger_flag;

// Modified to use trigger_base_clock_sig for clocking and trigger_clock_enable_sig for gating
always@(posedge trigger_base_clock_sig, negedge trigger_rst_n)
	if(~trigger_rst_n) tri_data	<= 1'b0; // Added asynchronous reset for tri_data
	else if (trigger_clock_enable_sig) // Only update when clock enable is active
		tri_data	<= tx_data;

// Modified to use trigger_base_clock_sig for clocking and trigger_clock_enable_sig for gating
always@(posedge trigger_base_clock_sig, negedge trigger_rst_n)
	if(~trigger_rst_n) trigger_flag <= 1'b0; // Added asynchronous reset, resolves SYNTH_89
	else if (trigger_clock_enable_sig) // Only update when clock enable is active
				trigger_flag<= ~trigger_flag;

reg	[23:0]	counter;
// Modified to use trigger_base_clock_sig for clocking and trigger_clock_enable_sig for gating
always@(posedge trigger_base_clock_sig,negedge trigger_rst_n)
	if(~trigger_rst_n)	counter	<= 24'd0;
	else if (trigger_clock_enable_sig) // Only update when clock enable is active
				counter	<= counter + 1'b1;
//---->> DEBUG HERE <<--------------------
reg			post_sck;
always@(posedge clock)
	post_sck	<= sck;

assign		can_ref_new_data	= (ACTIVE==1)? (!post_sck & sck) : (post_sck & !sck);
//----<< DEBUG HERE >>--------------------
assign	trigger_cnt			= counter;
assign	idle				= cs_n;

reg		miso_reg;
always@(*)
	case({ACTIVE==1,PHASE==1})
	2'b00:	miso_reg	= tx_data;
	2'b10:	miso_reg	= wr_data;
	2'b01:	miso_reg	= tri_data;
	2'b11:	miso_reg	= tri_data;
	default: miso_reg	= 1'b0; // Added default assignment to prevent X generation
	endcase

assign	miso			= miso_reg;

endmodule
