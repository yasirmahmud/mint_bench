module curve_stx_ve_775_20260112_003132_121430_w37744_attempt18 (
  input wire clk,
  input wire rst_n,
  output reg out_reg
);

  // An 'initial' block is not allowed inside a function in Verilog-2001.
  function automatic integer my_func;
    input integer a;
    initial begin // STX_VE_775 violation expected here
      $display("This initial block is in an invalid scope.");
      a = a + 1; // Dummy operation to ensure 'a' is modified if 'initial' was allowed
    end
    my_func = a;
  endfunction

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg <= 1'b0;
    end else begin
      // Call the function to ensure it's used and compiled, avoiding 'unused function' warnings.
      // The exact return value is not critical for demonstrating the rule.
      out_reg <= my_func(1);
    end
  end

endmodule
