module top17 (
  input logic clk,     // Added clock for sequential logic
  input logic rst_n,   // Added active-low reset for synthesizable initialization
  output logic [7:0] out_data[0:3] // Exposing 'data' to resolve 'set but not read' warning
);
  logic [7:0] data[0:3]; // Internal logic for the array

  // Replaced initial block with a synthesizable always_ff block for reset-based initialization.
  // This resolves the SYNTH_5143 (Initial block ignored for synthesis) warning.
  // Non-blocking assignments are correct for sequential logic within always_ff.
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Initialize data on reset, preserving the functional behavior of setting to 8'h55.
      for (int i = 0; i < 4; i = i + 1) begin
        data[i] <= 8'h55;
      end
    end
    // In the absence of other logic, data will retain its value when not in reset.
  end

  // Connect internal 'data' array to the output port 'out_data'.
  // This resolves the W528 (Variable 'data' set but not read) warning by making 'data' observable.
  genvar gi;
  for (gi = 0; gi < 4; gi = gi + 1) begin
    assign out_data[gi] = data[gi];
  end

endmodule
