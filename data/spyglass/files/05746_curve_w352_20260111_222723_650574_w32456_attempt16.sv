module curve_w352_20260111_222723_650574_w32456_attempt16 (
  input wire clk,
  input wire rst_n,
  input wire dummy_in,
  output reg dummy_out
);

  integer i;
  parameter MY_PARAM = 10;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      dummy_out <= 1'b0;
    end else begin
      // Default assignment to dummy_out in this path to prevent latches
      // in case the for loop below does not execute.
      dummy_out <= dummy_in;

      // W352: The 'for' condition is constant - the loop will either never execute or never terminate.
      // The condition (MY_PARAM == 5) is always false (since MY_PARAM is 10),
      // causing the loop to never execute.
      for (i = 0; MY_PARAM == 5; i = i + 1) begin
        // This code block is unreachable as the loop condition is constant false.
        // 'i' and 'dummy_in' are used here to avoid W481a (unused signal) warnings
        // for 'i' and 'dummy_in', even though the statement is unreachable.
        dummy_out <= dummy_in & i[0];
      end
    end
  end

endmodule
