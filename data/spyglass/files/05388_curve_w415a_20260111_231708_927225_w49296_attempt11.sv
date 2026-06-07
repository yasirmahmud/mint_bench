module curve_w415a_20260111_231708_927225_w49296_attempt11 (
  input wire [3:0] in_data,
  output reg [3:0] out_data
);

  integer idx;
  reg [3:0] result_reg; // Target signal for W415a violation

  always @* begin
    // Initialize the result_reg; this assignment is outside the loop
    // but the subsequent assignments within the loop are the violation.
    result_reg = 4'b0000;

    for (idx = 0; idx < 4; idx = idx + 1) begin
      // W415a violation: result_reg is assigned multiple times within this for-loop
      // (once per iteration, for a total of 4 assignments in this always block execution).
      if (in_data[idx] == 1'b1) begin
        result_reg = idx; // Assignment 1 within the loop
      end else begin
        result_reg = {1'b0, in_data[idx]}; // Assignment 2 within the loop (in the else branch)
      end
    end
    out_data = result_reg;
  end

endmodule
