module nested_translate_off_example (
  input wire clk,
  output reg out_reg
);

  always @(posedge clk) begin
    // pragma translate_off
    // Outer translate_off block
    if (1) begin
      // pragma translate_off
      // Inner translate_off block - this triggers the warning
      out_reg <= 1'b0;
      // pragma translate_on
    end
    // pragma translate_on
  end

endmodule
