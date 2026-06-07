module curve_noassignx_ml_20260111_231355_349209_w38092_attempt11 (
  input wire select,
  output reg [3:0] result
);

  // This always block assigns a value with 'X' to 'result'
  // when 'select' is high, triggering the NoAssignX-ML rule.
  always @(*) begin
    if (select) begin
      result = 4'b10x1; // Triggers NoAssignX-ML
    end else begin
      result = 4'b0000;
    end
  end

endmodule
