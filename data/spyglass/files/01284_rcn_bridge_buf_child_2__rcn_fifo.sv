module rcn_fifo
(
    input rst,
    input clk,

    input [68:0] rcn_in,
    input push,
    output full,

    output [68:0] rcn_out,
    input pop,
    output empty
);

    parameter DEPTH = 4; // Arbitrary depth, can be adjusted based on requirements
    // ADDR_WIDTH must be at least 1 to avoid zero-width registers if DEPTH is 1 ($clog2(1)=0)
    localparam ADDR_WIDTH = (DEPTH == 1) ? 1 : $clog2(DEPTH);

    reg [68:0] mem [0:DEPTH-1]; // Memory array to store RCN messages
    reg [ADDR_WIDTH-1:0] wptr;  // Write pointer
    reg [ADDR_WIDTH-1:0] rptr;  // Read pointer
    reg [ADDR_WIDTH:0] count;   // Current number of elements in FIFO

    // FIFO status signals
    assign empty = (count == 0);
    assign full = (count == DEPTH);

    // Output data from the FIFO, always points to the element at rptr
    assign rcn_out = mem[rptr];

    // Determine if push and pop operations are valid (combinational logic)
    wire push_en = push && !full;
    wire pop_en = pop && !empty;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wptr <= {ADDR_WIDTH{1'b0}};    // Initialize write pointer to 0
            rptr <= {ADDR_WIDTH{1'b0}};    // Initialize read pointer to 0
            count <= {ADDR_WIDTH+1{1'b0}}; // Initialize element count to 0
        end else begin
            // Update write pointer and store data in memory
            if (push_en) begin
                mem[wptr] <= rcn_in;
                wptr <= wptr + 1; // Pointer naturally wraps around due to bit-width
            end

            // Update read pointer
            if (pop_en) begin
                rptr <= rptr + 1; // Pointer naturally wraps around due to bit-width
            end

            // Update count of elements in the FIFO
            if (push_en && !pop_en) begin
                count <= count + 1;
            end else if (!push_en && pop_en) begin
                count <= count - 1;
            end
            // If both push_en and pop_en are true, count remains unchanged.
            // If neither is true, count remains unchanged.
        end
    end

endmodule
