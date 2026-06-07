module curve_w415_20260111_154018_082911_w11684_attempt2 (
  input wire clk,
  input wire reset,
  input wire data_a,
  input wire data_b,
  output reg out_reg
);

  // This always block drives 'out_reg'
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= data_a; // First driver for out_reg
    end
  end

  // This separate always block also drives 'out_reg' simultaneously,
  // leading to multiple drivers for the same register.
  always @(posedge clk) begin
    if (data_b) begin
      out_reg <= 1'b1; // Second driver for out_reg
    end else begin
      out_reg <= 1'b0;
    end
  end

endmodule
