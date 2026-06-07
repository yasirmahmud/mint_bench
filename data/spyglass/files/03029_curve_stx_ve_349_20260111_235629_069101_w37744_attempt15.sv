module curve_stx_ve_349_20260111_235629_069101_w37744_attempt15 (
  output reg dummy_output
);

  // A user-defined function where an undefined system task/function 'exit' is called.
  // Functions are distinct contexts from tasks or always/initial blocks for this violation.
  function automatic [7:0] my_data_processor;
    input [7:0] value_in;
    begin
      if (value_in > 4'd5) begin
        // STX_VE_349 violation: Task or function name ( exit ) not defined
        // The 'exit' system task/function is not recognized as defined in this context.
        exit;
      end
      my_data_processor = value_in + 4'd1;
    end
  endfunction

  reg [7:0] processed_data_reg;

  initial begin
    processed_data_reg = 8'd0; // Initialize to avoid X propagation
    dummy_output = 1'b0;

    // Call the function, which will attempt to execute the undefined 'exit'.
    processed_data_reg = my_data_processor(8'd7); // Input > 5, so 'exit' path is taken
    
    // Use processed_data_reg to avoid unused signal warning
    if (processed_data_reg == 8'd8) begin
      dummy_output = 1'b1;
    end
  end

endmodule
