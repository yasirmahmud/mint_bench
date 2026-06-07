module test_cross_iff;
  logic clk;
  logic [1:0] sig1;
  logic [1:0] sig2;
  logic enable;

  covergroup cg @(posedge clk);
    cp1: coverpoint sig1;
    cp2: coverpoint sig2 iff (enable);
    cross cp1, cp2;
  endgroup

  cg c_inst = new();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    enable = 0;
    sig1 = 0; sig2 = 0;
    #10 enable = 1;
    sig1 = 1; sig2 = 1;
    #10 $finish;
  end
endmodule
