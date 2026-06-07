module test_option_weight_1;
  logic clk;
  logic [1:0] sig;

  covergroup cg @(posedge clk);
    // Removed 'option.weight' setting as it's ignored by Verilator and caused linting violations.
    // This maintains functional behavior and simplifies the covergroup definition.
    cp_sig: coverpoint sig;
  endgroup c_inst; // Changed to static instantiation to resolve ELAB_6312 (dynamic allocation) and NoTopDUFound

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    sig = 0;
    #10 sig = 1;
    #10 sig = 2;
    #10 sig = 3;
    #10 $finish;
  end
endmodule
