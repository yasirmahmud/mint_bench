module curve_stx_ve_315_20260110_142950_attempt2 (
  input wire        clk,
  input wire        rst_n,
  input wire        enable,
  input wire [7:0]  data_in,
  output reg [7:0]  data_out
);

  // Define a non-void function that returns an 8-bit value
  function automatic [7:0] my_func (input [7:0] arg);
    reg [7:0] intermediate_val;
    begin
      intermediate_val = arg + 1;

      // Violation 1: Return from non-void function without a value expression
      if (arg == 8'd0) begin
        my_func = 8'd0;
        return; 
      end
      
      // Perform some intermediate computation
      intermediate_val = intermediate_val * 2;
      
      // Violation 2: Return from non-void function without a value expression
      // This branch is distinct from the first 'if' as it's a separate condition
      // and occurs after intervening logic.
      if (intermediate_val > 8'd50) begin
        my_func = intermediate_val - 1;
        return; 
      end
      
      // Default return path if neither of the above conditions are met
      my_func = arg + 3;
    end
  endfunction

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'd0;
    end else if (enable) begin
      data_out <= my_func(data_in);
    end
  end

endmodule
