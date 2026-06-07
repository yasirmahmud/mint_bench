module MultiBitNotifierInteger;
  reg clk;
  reg data_in;
  integer notifier_int; // Integer notifier (implicitly multi-bit)

  initial begin
    clk = 0;
    data_in = 0;
    notifier_int = 0;
  end

  always #5 clk = ~clk;

  // Timing check with an 'integer' notifier
  $setup(data_in, posedge clk, 10, notifier_int);

endmodule
