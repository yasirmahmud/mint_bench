module curve_starc05_2_5_1_9_20260110_192032_attempt7 (
  input wire sel,
  input wire data_in,
  output tri out_tri,
  output reg result1,
  output reg result2
);

  // Define the tri-state output
  assign out_tri = sel ? 1'bz : data_in;

  // To resolve STARC05-2.5.1.9, avoid using the tri-state output 'out_tri'
  // directly in the casez select expression. Instead, the logic is rewritten
  // to evaluate the conditions that drive out_tri (sel and data_in).
  always @(*) begin
    if (sel == 1'b1) begin // If sel is high, out_tri would be 1'bz
      // In this case, the original casez would hit 'default' for 1'bz
      result1 = 1'bx;
      result2 = 1'bx;
    end else begin // If sel is low, out_tri is driven by data_in
      // Now, use data_in directly in the casez statements.
      // First casez statement for result1
      casez (data_in)
        1'b0: result1 = 1'b0;
        1'b1: result1 = 1'b1;
        default: result1 = 1'bx; // Handles 'x' or 'z' values from data_in
      endcase

      // Second casez statement for result2
      casez (data_in)
        1'b0: result2 = 1'b1;
        1'b1: result2 = 1'b0;
        default: result2 = 1'bx; // Handles 'x' or 'z' values from data_in
      endcase
    end
  end

endmodule
