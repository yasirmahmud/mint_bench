module curve_noassignx_ml_20260111_155550_573185_w21676_attempt1 (
  output reg out
);

  // This assignment directly includes 'x' on the RHS, triggering NoAssignX-ML.
  always @(posedge 1'b1) begin // Use posedge 1'b1 to represent an unclocked always block, common for combinational logic or initial values.
    out = 1'bx;
  end

endmodule
