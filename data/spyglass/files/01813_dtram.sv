module dtram(
		adr,
		do,
		di,
		we,
		pwrdown,
		clk
		);

input	[`dt_index:0]	adr;
input	[`dt_msb:0]	di ;
output	[`dt_msb:0]	do ;
input			clk;
input			we ;
input			pwrdown;


wire	we_ ;
wire	unknown_adr ;


// synopsys translate_off

// Dtag ram instantiated, maxblocks = 256 in decaf
reg [`dt_msb:0] t_ram [0:`dt_mxblks] ;


assign we_      = ~(we & !pwrdown & ~clk);
assign unknown_adr = (^adr === 1'bx) ;

// Dtag Read
assign do[`dt_msb:0]   = (pwrdown | unknown_adr)? {do[`dt_msb:0]}:t_ram[adr];

// Write Dtag
always @(negedge we_) t_ram[adr] = di;

// synopsys translate_on

endmodule
