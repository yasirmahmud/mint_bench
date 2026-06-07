module curve_w123_20260111_231751_325834_w28836_attempt11 (
  input clk,
  input reset_n,
  output reg out_signal
);

  // Declare an extremely wide register. The width (2^23 bits, 8388608 total bits)
  // is chosen to be definitively "too big" for default processing by SpyGlass,
  // triggering exactly one W123 rule violation. This specific size is distinct
  // from previous examples, and the name 'wide_data_register' is also distinct.
  reg [8388607:0] wide_data_register; // 2^23 bits wide (MSB:8388607, LSB:0)

  // Use the wide register in a simple synchronous block to ensure it is considered active
  // and not optimized away by the tool. This block avoids latches and multiple drivers.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      wide_data_register <= '0; // Reset all bits to 0 on active low reset
    end else begin
      wide_data_register <= wide_data_register + 1; // Example operation: increment
    end
  end

  // Assign a single bit from the wide register to an output. This ensures the bus's usage
  // is visible to the tool and prevents the entire register from being optimized away
  // due to being unused. This minimal usage should not trigger any other rules.
  assign out_signal = wide_data_register[123];

endmodule
