module VC_WRN_ASGN_PATTERN_ex1 (
    input wire clk,
    input wire rst_n,
    output wire [7:0] out_data_0,
    output wire [7:0] out_data_1
);

  reg [7:0] data_array [0:1];

  // Resolve SYNTH_5143: "Initial block is ignored for synthesis"
  // by using a synthesizable synchronous reset to initialize the array.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_array[0] <= 8'hAA;
      data_array[1] <= 8'hBB;
    end
    // No 'else' behavior is needed as data_array's value is intended to be constant after reset
    // unless other logic is added to modify it.
  end

  // Resolve W528: "Variable 'data_array' set but not read."
  // by making the array elements visible as outputs.
  assign out_data_0 = data_array[0];
  assign out_data_1 = data_array[1];

endmodule
