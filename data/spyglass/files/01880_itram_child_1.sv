module itram(
                adr,
                do,
                di,
                we,
                enable,
                clk
                );

// Define local parameters to resolve undefined macro violations (STX_VE_533)
// Assuming a 32-bit data bus and 512 memory locations based on common RAM configurations.
localparam ADDR_MSB  = 8;   // Corresponds to 'it_index'. For 512 locations (0-511), address is 9 bits wide (adr[8:0]).
localparam DATA_MSB  = 31;  // Corresponds to 'it_msb+1'. For 32-bit data (di[31:0]), the MSB is 31.
localparam RAM_SIZE  = 512; // Corresponds to 'it_mxblks' (max index), so RAM array is [RAM_SIZE-1:0].

input   [ADDR_MSB:0]    adr;
input   [DATA_MSB:0]    di;
output  [DATA_MSB:0]    do;
input                   clk;
input                   we;
input                   enable;


wire    we_ ;
wire    unknown_adr;



// itag ram instantiated, maxblocks = 512 by default
reg [DATA_MSB:0] t_ram [RAM_SIZE-1:0] ;


assign we_      = ~(we & enable & ~clk);

assign unknown_adr = (^adr === 1'bx) ;

// Itag Read
// Replaced 'it_msb' with '(DATA_MSB-1)' for the bit replication count, as 'it_msb' was effectively (DATA_WIDTH-2).
// Example: if DATA_MSB=31 (32-bit data), then DATA_MSB-1 = 30. Original '{2'bx,{`it_msb{1'bx}}}' becomes '{2'bx,{30{1'bx}}}'.
assign do[DATA_MSB:0]   = (!enable)? (do[DATA_MSB:0]):
                            ((unknown_adr)? {2'bx,{(DATA_MSB-1){1'bx}}}:t_ram[adr]);

// Write itag
always @(negedge we_) t_ram[adr] = di;

endmodule
