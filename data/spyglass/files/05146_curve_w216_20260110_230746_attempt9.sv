module curve_w216_20260110_230746_attempt9 (
  input wire clk,
  input wire rst_n,
  output reg [7:0] byte_output
);

  // Declare an integer variable. SpyGlass typically treats 'integer' as 32-bit.
  integer counter_var; // This is the 'int_part_sel variable' as per W216 description

  // Use a synchronous always block to make this distinct from previous examples
  // and to simulate a 'counter' as suggested by the rule description.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter_var <= 0; // Reset the integer counter
      byte_output <= 8'h0;
    end else begin
      counter_var <= counter_var + 1; // Increment the integer counter

      // This line is specifically designed to trigger SpyGlass W216.
      // W216 flags "Inappropriate range select for int_part_sel variable".
      // SpyGlass considers selecting a specific range like [7:0] from an 'integer'
      // (which is typically implicitly 32-bit) and assigning it to a smaller-width
      // register/wire as redundant or potentially confusing.
      // A direct assignment `byte_output <= counter_var;` would achieve the same
      // implicit truncation to 8 bits for the lower bits, making the explicit
      // range selection `[7:0]` unnecessary from SpyGlass's perspective.
      byte_output <= counter_var[7:0]; // Expected W216 violation here
    end
  end

endmodule
