module my_module_ex2(input clk);
  reg dummy_q;

  // Using clk to avoid W240 violation
  always @(posedge clk) begin
    dummy_q <= 1'b0; // Dummy assignment to use the clock
  end
endmodule
