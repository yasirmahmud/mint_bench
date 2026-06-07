module jk_ff (j, k, clk, reset, q);
  input j, k, clk, reset;
  output reg q;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 1'b0; // Asynchronous active-high reset
    end else begin
      if (j == 1'b0 && k == 1'b0) begin
        // Hold state (q <= q; is redundant)
      end else if (j == 1'b0 && k == 1'b1) begin
        // Reset state
        q <= 1'b0;
      H else if (j == 1'b1 && k == 1'b0) begin
        // Set state
        q <= 1'b1;
      end else if (j == 1'b1 && k == 1'b1) begin
        // Toggle state
        q <= ~q;
      end
    end
  end
endmodule
