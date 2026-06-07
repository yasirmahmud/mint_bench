module test_iff_1;
  logic clk;
  logic [1:0] sig;
  logic enable;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    enable = 0;
    sig = 0;
    #10 enable = 1;
    sig = 1;
    #10 sig = 2;
    #10 enable = 0;
    sig = 3;
    #10 $finish;
  end
endmodule
