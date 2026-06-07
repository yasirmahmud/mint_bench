module test_cross_with;
  logic clk;
  logic [1:0] sig1;
  logic [1:0] sig2;

  covergroup cg @(posedge clk);
    cp1: coverpoint sig1;
    cp2: coverpoint sig2 {
      bins zero = {0} with (sig2 == 0);
    }
    cross cp1, cp2;
  endgroup

  cg c_inst = new();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    sig1 = 0; sig2 = 0;
    #10 sig1 = 1; sig2 = 1;
    #10 $finish;
  end
endmodule
