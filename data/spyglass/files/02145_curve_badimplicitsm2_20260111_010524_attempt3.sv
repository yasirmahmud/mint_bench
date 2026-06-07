module curve_badimplicitsm2_20260111_010524_attempt3 (
  input wire [7:0] data_input,
  input wire main_clk,
  output reg [7:0] posedge_capture_reg,
  output reg [7:0] negedge_capture_reg
);

  // This always block attempts to infer sequential logic for two different
  // registers, each triggered on a different clock edge within the SAME
  // always block. This implicitly creates a state machine that updates
  // states on different clock phases, which is unsynthesizable.
  always begin
    @(posedge main_clk) posedge_capture_reg <= data_input;
    @(negedge main_clk) negedge_capture_reg <= data_input ^ 8'hFF; // Example with different logic
  end

endmodule
