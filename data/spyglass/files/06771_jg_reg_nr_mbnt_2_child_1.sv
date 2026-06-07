module MultiBitNotifierInteger;
  reg clk;
  reg data_in;
  reg notifier_int; // Changed from 'integer' to 'reg' to be a single-bit notifier

  initial begin
    clk = 0;
    data_in = 0;
    notifier_int = 0;
  end

  always #5 clk = ~clk;

  // Timing check with a 'reg' notifier (now single-bit as required by LRM for $setup)
  $setup(data_in, posedge clk, 10, notifier_int);

endmodule
