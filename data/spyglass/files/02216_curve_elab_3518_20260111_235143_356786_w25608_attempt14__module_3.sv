// ELAB_3518 violation: Overriding the integer parameter 'DATA_RATE_FACTOR'
  // with a double-type value (7.3) in the instance named 'dcm_sp_inst'.
  // This directly triggers the ELAB_3518 rule.
  SUB_ELAB3518 #(.DATA_RATE_FACTOR(7.3)) dcm_sp_inst (
    .logic_in  (clk),
    .logic_out (internal_data)
  );

  always @(posedge clk) begin
    out_signal <= internal_data;
  end

endmodule
