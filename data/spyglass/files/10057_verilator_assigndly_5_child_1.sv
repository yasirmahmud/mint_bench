module example_05;
  reg clk; // Moved declaration to resolve STX_VE_606
  reg g;
  reg h;
  always @(posedge clk) begin
    g <= h; // Removed explicit delay #15 to resolve ASSIGNDLY warning
  end
  initial clk = 0;
endmodule
