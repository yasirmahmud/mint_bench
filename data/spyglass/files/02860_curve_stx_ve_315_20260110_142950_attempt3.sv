module curve_stx_ve_315_20260110_142950_attempt3 (
  input wire        clk,
  input wire        rst_n,
  input wire        enable,
  input wire [7:0]  data_in,
  output reg [7:0]  data_out
);

  // Define a non-void function that returns an 8-bit value
  function automatic [7:0] my_func (input [7:0] arg);
    reg [7:0] temp_val;
    begin
      temp_val = arg + 1;

      if (arg > 8'd10) begin
        // Violation 1: return from non-void function 'my_func' must have a value expression
        // The rule triggers on 'return;' itself, even if the function's return value
        // has been assigned right before it.
        my_func = temp_val + 2;
        return; 
      end else if (arg == 8'd5) begin
        // Violation 2: Another instance of 'return;' without an explicit value expression.
        // This case is distinct from attempt 2 as it uses an if-else if chain.
        my_func = 8'd0;
        return; 
      end else begin
        // Default return path if neither of the above conditions are met
        my_func = arg * 2;
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
