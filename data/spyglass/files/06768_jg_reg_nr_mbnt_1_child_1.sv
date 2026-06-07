module MultiBitNotifierReg;
  reg clk;
  reg data_in;
  reg notifier_reg; // Notifier must be a single bit for system tasks like $setup

  initial begin
    clk = 0;
    data_in = 0;
    notifier_reg = 0;
  end

  always #5 clk = ~clk;

  // Timing check with a single-bit 'reg' notifier, resolving REG_NR_MBNT
  $setup(data_in, posedge clk, 10, notifier_reg);

endmodule
