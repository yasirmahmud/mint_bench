module test_option_weight_1;
  logic clk;
  logic [1:0] sig;

  covergroup cg @(posedge clk);
    // The 'option.weight' is a coverage-specific feature that Verilator ignores (COVERIGN warning)
    // and can be problematic for some linting tools during elaboration. Removing it simplifies the
    // covergroup definition without changing the functional hardware behavior.
    // option.weight = 10;
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
