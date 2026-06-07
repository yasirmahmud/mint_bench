module curve_stx_ve_349_20260111_235629_069101_w37744_attempt13 (
  input wire clk,
  input wire rst_n,
  input wire trigger,
  output reg out_data
);

  // A function is defined that conditionally calls an undefined task/function named 'exit'.
  // This structure ensures that STX_VE_349 is triggered exactly once for the call to 'exit'.
  function automatic [0:0] my_check_func;
    input [0:0] enable_violation;
    begin
      if (enable_violation) begin
        // STX_VE_349 violation: Task or function name ( exit ) not defined
        exit; 
      end
      my_check_func = 1'b0;
    end
  endfunction

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data <= 1'b0;
    end else begin
      // The function is called here; if 'trigger' is high, the 'exit' call within the function will be elaborated.
      out_data <= my_check_func(trigger);
    end
  end

endmodule
