module FIR_Filter 
#(
    parameter DATA_IN_WIDTH  = 16,
    parameter DATA_OUT_WIDTH = 32,
    parameter TAP_WIDTH      = 16,
    parameter TAP_COUNT      = 50
)
(
    input wire                               clk,
    input wire                               reset_n,
    input wire   signed [DATA_IN_WIDTH-1:0]  data_in,
    output reg   signed [DATA_OUT_WIDTH-1:0] data_out
);

// Internal variables
integer i;

// Coefficient values
reg signed [TAP_WIDTH-1:0]  taps       [0:TAP_COUNT-1];

// Delay line
reg signed [DATA_IN_WIDTH-1:0] delay [0:TAP_COUNT-1];

// Temporary variable for sum calculation to avoid multiple assignments to data_out.
// Changed to wire, as it's a combinational signal for the current cycle's calculation.
wire signed [DATA_OUT_WIDTH-1:0] current_sum;

// Combinational block to compute filter output. This separates the combinatorial sum
// calculation from the sequential logic, resolving multiple assignment warnings.
always_comb begin
    current_sum = 0; // Initialize for current cycle's calculation (blocking assignment)
    for (i = 0; i < TAP_COUNT; i = i + 1) begin
        // Accumulate using blocking assignment. Product width is DATA_IN_WIDTH + TAP_WIDTH,
        // which is then added to current_sum, potentially truncating to DATA_OUT_WIDTH.
        current_sum = current_sum + (delay[i] * taps[i]); 
    end
end

// Filter operation
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // Reset delay, output, and initialize taps. This resolves 'initial block ignored for synthesis'
        // and 'undriven input terminal' violations by making tap initialization synthesizable.
        for (i = 0; i < TAP_COUNT; i = i + 1) begin
            delay[i] <= 0;
            taps[i] <= 16'b0000000000100001; // Default tap value, synthesizable initialization on reset
        end
        data_out <= 0;
    end else begin
        // Shift data into delay 
        for (i = TAP_COUNT-1; i > 0; i = i - 1)
            delay[i] <= delay[i-1];
        delay[0] <= data_in;

        // Assign the final combinational sum to the output register once (non-blocking)
        data_out <= current_sum; 
    end
end

endmodule
