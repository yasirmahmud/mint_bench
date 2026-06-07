module curve_noassignx_ml_20260111_200027_127799_w47100_attempt10 (
  output reg out_signal
);

  // This always block continuously assigns an 'x' value to 'out_signal'.
  // The direct assignment of '1'bx on the RHS triggers the NoAssignX-ML rule
  // because the RHS contains 'X' and it functions as an initialization of the
  // register's value within this combinational block's context.
  always @(*) begin
    out_signal = 1'bx;
  end

endmodule
