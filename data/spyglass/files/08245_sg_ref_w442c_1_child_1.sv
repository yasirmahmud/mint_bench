module w442c_ex1 (input clk, input reset_n, input data_in, input some_other_condition, output reg q);
  always @(posedge clk or negedge reset_n) begin
    // Violation W442f: "Only '==' and '!=' binary operators are allowed in validation of the asynchronous reset/set condition"
    // The original condition `reset_n && some_other_condition` uses an implicit comparison for `reset_n` and `some_other_condition`.
    // To resolve this while preserving functional behavior, explicit `== 1'b1` comparisons are used.
    if ((reset_n == 1'b1) && (some_other_condition == 1'b1)) begin
      q <= 1'b0;
    end else begin
      q <= data_in;
    end
  end
endmodule
