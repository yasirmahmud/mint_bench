module stram(
                adr1,
		adr2,
                do,
                di,
                we,
		pwrdown,
                clk
                );
 
input   [`dt_index:0]   adr1;	// used for read of status register
input   [`dt_index:0]   adr2;	// used for write into status register
input   [4:0]     	di ;	// data in
output  [4:0]     	do ;	// data out
input                   clk;
input   [4:0]           we ;	// write enable
input			pwrdown;// Power Down
 
 
wire    	we_ ;
wire	[4:0]	do_int;
wire		unknown_adr ;
wire		statwe ;
wire	[4:0]	tmp;
 

// synopsys translate_off
 
// Dtag Status ram instantiated, maxblocks = 256 in decaf
reg [4:0]stram [0:`dt_mxblks] ;
 
assign	statwe = we[4] | we[3] | we[2] | we[1] | we[0] ;
assign we_  = ~(statwe & !pwrdown & ~clk) ;
assign unknown_adr = (^adr1 === 1'bx) ;
 
// Status Read
assign do[4:0]     = (pwrdown | unknown_adr)?do[4:0]:stram[adr1[`dt_index:0]];
 
// Write status reg
assign do_int[4:0]	= stram[adr2[`dt_index:0]] ;
assign	tmp[4]	= (we[4] & !pwrdown )? di[4]: do_int[4] ;
assign	tmp[3]	= (we[3] & !pwrdown )? di[3]: do_int[3] ;
assign	tmp[2]	= (we[2] & !pwrdown )? di[2]: do_int[2] ;
assign	tmp[1]	= (we[1] & !pwrdown )? di[1]: do_int[1] ;
assign	tmp[0]	= (we[0] & !pwrdown )? di[0]: do_int[0] ;
always @(negedge we_) stram[adr2] = tmp[4:0] ;
 
// synopsys translate_on
 
endmodule
