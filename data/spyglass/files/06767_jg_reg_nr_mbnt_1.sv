module MultiBitNotifierReg;
  reg clk;
  reg data_in;
  reg [1:0] notifier_reg; // Notifier greater than 1 bit

  initial begin
    clk = 0;
    data_in = 0;
    notifier_reg = 0;
  end

  always #5 clk = ~clk;

  // Timing check with a multi-bit 'reg' notifier
  $setup(data_in, posedge clk, 10, notifier_reg);

endmodule
