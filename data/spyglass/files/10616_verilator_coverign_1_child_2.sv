module test_cross_1;
  logic clk;
  logic [1:0] sig1;
  logic [1:0] sig2;

  covergroup cg @(posedge clk);
    cp1: coverpoint sig1;
    cp2: coverpoint sig2;
    cross cp1, cp2;
  endgroup

  // The previous line 'cg c_inst();' caused a SpyGlass STX_VE_481 syntax error.
  // The correct SystemVerilog syntax for covergroup instantiation is 'covergroup_type instance_name = new();'.
  // This resolves the syntax violation while preserving the covergroup's intended behavior.
  cg c_inst = new();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    sig1 = 0;
    sig2 = 0;
    #10 sig1 = 1;
    #10 sig2 = 1;
    #10 sig1 = 2;
    #10 sig2 = 2;
    #10 $finish;
  end
endmodule
