module curve_badimplicitsm1_20260111_225341_707843_w32456_attempt12 (
  input clk,
  input rst_n, // Asynchronous active-low reset
  input data_in,
  input enable_reg, // A regular control signal
  output reg q
);

  always @(posedge clk or negedge rst_n) begin
    // Violation: The 'enable_reg' condition is checked before the asynchronous reset 'rst_n'.
    // Rule badimplicitSM1 requires asynchronous reset/set signals to be checked first in an if-else if chain.
    if (enable_reg) begin // Non-reset condition checked first
      q <= data_in;
    end else if (!rst_n) begin // Asynchronous active-low reset
      q <= 1'b0;
    end else begin
      q <= q; // Maintain state synchronously
    end
  end

endmodule
