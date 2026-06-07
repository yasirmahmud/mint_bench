module curve_w216_20260110_230746_attempt7 (
  input wire clk,
  input wire rst_n,
  output reg [7:0] data_out
);

  // Declare an integer variable. SpyGlass typically treats 'integer' as 32-bit.
  integer counter;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 0;
      data_out <= 8'h00;
    end else begin
      // Increment the counter
      counter <= counter + 1;

      // This line is specifically designed to trigger SpyGlass W216.
      // W216 flags "Inappropriate range select for int_part_sel variable".
      // SpyGlass considers selecting a range like [7:0] from an 'integer'
      // (which would implicitly be 32-bit) and assigning it to a smaller-width
      // register as redundant or potentially confusing. A direct assignment
      // `data_out <= counter;` would achieve the same implicit truncation
      // to 8 bits, making the explicit range selection unnecessary for the lower bits.
      data_out <= counter[7:0];
    end
  end

endmodule
