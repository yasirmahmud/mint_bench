module same_signal_assign_ex1 (input wire clk, input wire rst_n, input wire in1, input wire in2, output reg out_reg);
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg <= 1'b0;
    end else begin
      // In sequential logic, multiple assignments to the same signal within the same clock cycle
      // using non-blocking assignments result in the last assignment taking effect.
      // The original code `out_reg <= in1; out_reg <= in2;` effectively assigned `in2` to `out_reg`.
      // To resolve the multiple assignment violation while preserving this functional behavior,
      // we remove the redundant assignment to `in1`.
      out_reg <= in2;
    end
  end
endmodule
