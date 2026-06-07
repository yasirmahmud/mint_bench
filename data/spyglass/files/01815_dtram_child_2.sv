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
// The 'unknown_adr' wire and its assignment are removed to resolve STARC05-2.10.1.4a/b and W339a violations.
// Synthesis tools typically assume valid (0/1) inputs for 'adr'.

// Dtag ram instantiated, maxblocks = 256 in decaf
// The 'synopsys translate_off/on' directives were removed to ensure the RAM is implemented 
// and synthesizable, consistent with the design description "This module implements a ... RAM".
reg [DATA_WIDTH-1:0] t_ram [0:RAM_DEPTH-1] ;


assign we_      = ~(we & !pwrdown & ~clk);

// Dtag Read
// FIX: The original 'do' assignment implied a latch or combinational loop due to self-assignment.
// This has been updated to provide a synthesizable combinational read.
// When 'pwrdown' is active, 'do' outputs all zeros, consistent with the design being 'power-down-aware'
// and not 'enabled via a valid address' during power down.
assign do = pwrdown ? {DATA_WIDTH{1'b0}} : t_ram[adr];

// Write Dtag
always @(negedge we_) t_ram[adr] = di;


endmodule
