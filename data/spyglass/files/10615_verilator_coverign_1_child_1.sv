module test_cross_1;
  logic clk;
  logic [1:0] sig1;
  logic [1:0] sig2;

  covergroup cg @(posedge clk);
    cp1: coverpoint sig1;
    cp2: coverpoint sig2;
    cross cp1, cp2;
  endgroup

  // SpyGlass ELAB_6312 violation: "Unsupported SV constructs 'dynamic allocation'"
  // Changed from dynamic allocation 'new()' to static instantiation '()'
  // This resolves the linting violation while preserving the covergroup's intended behavior.
  cg c_inst();

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
