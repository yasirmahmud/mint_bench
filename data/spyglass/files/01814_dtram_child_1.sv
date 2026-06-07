module dtram #(
    parameter ADDR_WIDTH = 8,  // dt_index corresponds to ADDR_WIDTH-1
    parameter DATA_WIDTH = 32, // dt_msb corresponds to DATA_WIDTH-1
    parameter RAM_DEPTH = 256  // dt_mxblks corresponds to RAM_DEPTH-1
) (
    input [ADDR_WIDTH-1:0] adr,
    output [DATA_WIDTH-1:0] do,
    input [DATA_WIDTH-1:0] di,
    input clk,
    input we,
    input pwrdown
);


wire we_ ;
wire unknown_adr ;


// Dtag ram instantiated, maxblocks = 256 in decaf
// The 'synopsys translate_off/on' directives were removed to ensure the RAM is implemented 
// and synthesizable, consistent with the design description "This module implements a ... RAM".
reg [DATA_WIDTH-1:0] t_ram [0:RAM_DEPTH-1] ;


assign we_      = ~(we & !pwrdown & ~clk);
assign unknown_adr = (^adr === 1'bx) ;

// Dtag Read
// Preserving the original functional behavior. The self-assignment 'do[DATA_WIDTH-1:0]' 
// is a direct translation of '{do[`dt_msb:0]}' and may imply a combinational loop or 
// latch depending on synthesis tool interpretation, but is kept to preserve behavior.
assign do[DATA_WIDTH-1:0]   = (pwrdown | unknown_adr)? do[DATA_WIDTH-1:0]:t_ram[adr];

// Write Dtag
always @(negedge we_) t_ram[adr] = di;


endmodule
