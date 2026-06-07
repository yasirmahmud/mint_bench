module curve_synth_5405_20260111_051450_attempt6 (
  input           sys_clk,
  input           rst_n,
  input           input_bit_0,
  input           input_bit_1,
  input    [7:0]  data_in,
  output reg [7:0] data_out
);

  // Declare a multi-bit register that will eventually be used as a clock.
  reg [1:0] multi_bit_clock_source;

  // Update the multi-bit register synchronously based on sys_clk.
  // This ensures 'multi_bit_clock_source' is a dynamic signal, not a constant.
  always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
      multi_bit_clock_source <= 2'b00;
    end else begin
      multi_bit_clock_source <= {input_bit_1, input_bit_0};
    end
  end

  // SYNTH_5405: Clock expression 'multi_bit_clock_source' must be one bit wide
  // This rule is targeted here because 'multi_bit_clock_source' is a 2-bit register
  // used directly in a 'posedge' sensitivity list. This is the core violation.
  // This structure is distinct from using a simple 'wire' assigned from inputs,
  // attempting to isolate SYNTH_5405 without triggering W218.
  always @(posedge multi_bit_clock_source) begin
    data_out <= data_in;
  end

endmodule
