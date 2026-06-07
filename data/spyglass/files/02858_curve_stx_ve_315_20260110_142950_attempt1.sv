module curve_stx_ve_315_20260110_142950_attempt1 (
  input wire        clk,
  input wire        rst_n,
  input wire        enable,
  input wire [7:0]  data_in,
  output reg [7:0]  data_out
);

  // Define a non-void function that returns an 8-bit value
  function automatic [7:0] my_func (input [7:0] arg);
    begin
      if (arg > 10) begin
        my_func = arg + 1; // Assign a value to the function return register
        return; // Violation 1: Return from non-void function without a value expression
      end else if (arg == 5) begin
        my_func = arg * 2; // Assign a value
        return; // Violation 2: Return from non-void function without a value expression
      end else begin
        my_func = arg - 1;
      end
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
