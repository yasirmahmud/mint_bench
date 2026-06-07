module curve_w122_20260111_200621_465827_w37940_attempt6 (
    input wire in0,
    input wire control_sig,
    output reg out_reg
);

  // W122 violation: 'in0' is read inside the block but is not in the sensitivity list.
  always @(control_sig) begin
    if (in0) begin // 'in0' is read here, but only 'control_sig' is in the sensitivity list.
      out_reg = 1'b1;
    end else begin
      out_reg = 1'b0;
    end
  end

endmodule
