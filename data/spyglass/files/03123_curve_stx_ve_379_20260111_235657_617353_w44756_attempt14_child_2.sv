module curve_stx_ve_379_20260111_235657_617353_w44756_attempt14_child_2 (
    input wire clk,
    input wire rst_n,
    output wire [15:0] current_sensor_value
);

  // Declares an array named 'sensor_data' with 4 elements, indices 0 to 3.
  reg [15:0] sensor_data [3:0];

  // Initialize sensor_data on power-on reset.
  // This resolves SYNTH_5143 (initial block ignored for synthesis),
  // WRN_1470 (unsupported array literal pattern), and
  // W240 (unused clk/rst_n inputs) violations.
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Active-low reset
      sensor_data[0] <= 16'h1111;
      sensor_data[1] <= 16'h0000; // Corresponds to the 'default' value from the original array literal
      sensor_data[2] <= 16'h3333;
      sensor_data[3] <= 16'h4444;
    end
    // No 'else' block is needed as the design description implies 'sensor_data'
    // are static after initialization; no dynamic behavior is described.
  end

  // Prevent unused signal violations for the array and output by driving the output.
  assign current_sensor_value = sensor_data[0];

endmodule
