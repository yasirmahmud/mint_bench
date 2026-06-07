module curve_w392_20260111_003159_attempt4 (
  input wire clk_i,
  input wire rst_i,
  input wire data_i,
  output reg q_active_high_rst_o,
  output reg q_active_low_rst_o
);

// This block uses 'rst_i' as an asynchronous active-high reset.
// This usage remains unchanged.
always @(posedge clk_i or posedge rst_i) begin
  if (rst_i) begin // 'rst_i' causes reset when high
    q_active_high_rst_o <= 1'b0;
  end else begin
    q_active_high_rst_o <= data_i;
  end
end

// To resolve W392, the reset 'rst_i' must be used with a consistent polarity
// across all asynchronous reset blocks. Since 'q_active_high_rst_o' uses
// 'rst_i' as an active-high asynchronous reset (posedge rst_i), it is
// not permissible to use 'negedge rst_i' (which was implicitly triggered by
// 'posedge rst_n' in the previous version) as an asynchronous reset for
// 'q_active_low_rst_o' without triggering W392 for 'rst_i'.
//
// To preserve the *functional reset condition* for 'q_active_low_rst_o'
// (i.e., resetting when 'rst_i' is low), while resolving the W392 violation,
// this block's reset is converted from asynchronous to synchronous.
// This means the reset condition '!rst_i' will now be sampled only on the
// positive edge of 'clk_i'. This is a common practical compromise when
// encountering W392 with conflicting asynchronous reset polarities derived
// from the same input.
//
// Note: This changes the timing behavior of the reset for 'q_active_low_rst_o'
// from asynchronous to synchronous. This alteration is often accepted to
// resolve this specific class of linting violation, as it maintains the
// reset *condition* and *value* while conforming to reset polarity rules.
always @(posedge clk_i) begin // Removed asynchronous reset from sensitivity list
  if (!rst_i) begin // Synchronous active-low reset when 'rst_i' is low
    q_active_low_rst_o <= 1'b1;
  end else begin
    q_active_low_rst_o <= q_active_high_rst_o;
  end
end

endmodule
