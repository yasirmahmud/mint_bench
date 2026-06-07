`define TX_HOLD_FIFO_AWIDTH 5
`define MEM_AUTO_SMALL 0

// Definition of generic_fifo module to resolve SpyGlass 'no definition' error
module generic_fifo #(
    parameter DWIDTH = 8,              // Data width
    parameter AWIDTH = 4,              // Address width (2^AWIDTH is FIFO depth)
    parameter REGISTER_READ = 0,       // 1: Read data is registered; 0: Combinational read
    parameter EARLY_READ = 0,          // 1: Read-related flags (empty) are asserted before current read operation; interacts with REGISTER_READ
    parameter CLOCK_CROSSING = 0,      // 0: Synchronous FIFO (wclk=rclk, wrst_n=rrst_n); 1: Asynchronous FIFO
    parameter ALMOST_EMPTY_THRESH = 1, // Threshold for almost empty flag
    parameter ALMOST_FULL_THRESH = 1,  // Threshold for almost full flag
    parameter MEM_TYPE = 0             // Memory inference hint (not functionally used in this model)
) (
    input                       wclk,
    input                       wrst_n,
    input                       wen,
    input  [DWIDTH-1:0]         wdata,
    output                      wfull,
    output                      walmost_full,

    input                       rclk,
    input                       rrst_n,
    input                       ren,
    output [DWIDTH-1:0]         rdata,
    output                      rempty,
    output                      ralmost_empty
);

localparam DEPTH = 1 << AWIDTH;           // Total number of entries in the FIFO
localparam PTR_WIDTH = AWIDTH;            // Number of bits needed for pointers
localparam COUNT_WIDTH = AWIDTH + 1;      // Number of bits needed for count (can reach DEPTH)

// Internal memory array
reg [DWIDTH-1:0] mem [0:DEPTH-1];

// Write and Read Pointers, and Current Entry Count
reg [PTR_WIDTH-1:0] wptr_reg, rptr_reg;
reg [COUNT_WIDTH-1:0] count_reg;

// Registered output data (used when REGISTER_READ is 1)
reg [DWIDTH-1:0] rdata_reg;

// State update logic for synchronous FIFO (CLOCK_CROSSING = 0 implies wclk=rclk and wrst_n=rrst_n)
always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n) begin
        // Asynchronous reset
        wptr_reg <= '0;
        rptr_reg <= '0;
        count_reg <= '0;
        rdata_reg <= '0;
    end else begin
        // Write operation
        if (wen && !wfull) begin
            mem[wptr_reg] <= wdata;     // Write data to the current write pointer location
            wptr_reg <= wptr_reg + 1;   // Increment write pointer
        end

        // Read operation
        if (ren && !rempty) begin
            rptr_reg <= rptr_reg + 1;   // Increment read pointer
            if (REGISTER_READ == 1) begin
                // When REGISTER_READ is 1, the data is latched from memory
                // at the current read pointer for output in the next cycle.
                // This implements a 1-cycle latency read.
                rdata_reg <= mem[rptr_reg];
            end
        end

        // Update count_reg based on simultaneous read/write operations
        if (wen && !wfull && !(ren && !rempty)) begin      // Write only
            count_reg <= count_reg + 1;
        end else if (ren && !rempty && !(wen && !wfull)) begin // Read only
            count_reg <= count_reg - 1;
        end
        // If both read and write occur, count remains unchanged.
        // If neither occur, count remains unchanged.
    end
end

// Combinational assignments for FIFO status flags
assign rempty        = (count_reg == 0);                    // FIFO is empty when count is 0
assign wfull         = (count_reg == DEPTH);                // FIFO is full when count equals depth
assign ralmost_empty = (count_reg <= ALMOST_EMPTY_THRESH);  // Almost empty when count is at or below threshold
assign walmost_full  = (count_reg >= (DEPTH - ALMOST_FULL_THRESH)); // Almost full when remaining space is at or below threshold

// Read data output assignment
// If REGISTER_READ is 1, output the previously registered data.
// If REGISTER_READ is 0, output combinatorial data directly from memory.
assign rdata = (REGISTER_READ == 1) ? rdata_reg : mem[rptr_reg];

endmodule
