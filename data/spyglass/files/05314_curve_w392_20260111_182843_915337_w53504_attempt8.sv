module curve_w392_20260111_182843_915337_w53504_attempt8 (
  input wire clk_i,
  input wire rst_sig, // This reset signal will trigger the W392 violation
  input wire data_i,
  output reg q_al,    // Output of the flip-flop reset active-low
  output reg q_ah     // Output of the flip-flop reset active-high
);

  // Register 1: Asynchronous active-low reset
  // rst_sig is used here as an active-low asynchronous reset
  always @(posedge clk_i or negedge rst_sig) begin
    if (!rst_sig) begin // Active-low assertion
      q_al <= 1'b0;
    end else begin
      q_al <= data_i;
    end
  end

  // Register 2: Asynchronous active-high reset
  // rst_sig is used here as an active-high asynchronous reset.
  // This usage, combined with the active-low usage above for the *same* rst_sig,
  // triggers the W392 violation.
  always @(posedge clk_i or posedge rst_sig) begin
    if (rst_sig) begin // Active-high assertion
      q_ah <= 1'b0;
    end else begin
      q_ah <= data_i;
    end
  end

endmodule
