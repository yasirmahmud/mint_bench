module curve_stx_ve_396_20260111_184323_023959_w53504_attempt9();

  event my_custom_event;
  reg output_data_reg;

  // STX_VE_396 violation: Invalid reference to event 'my_custom_event'
  // An event cannot be evaluated in a boolean context like an 'if' condition.
  always @* begin
    if (my_custom_event) begin
      output_data_reg = 1'b1;
    end else begin
      output_data_reg = 1'b0;
    end
  end

endmodule
