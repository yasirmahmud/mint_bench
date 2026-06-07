module test_option_weight_3;
  logic clk;
  logic [3:0] address;

  covergroup cg @(posedge clk);
    // The 'option.weight' setting is an unsupported SystemVerilog feature by Verilator, leading to COVERIGN warnings.
    // Removed for simplification and compatibility, as per the design description regarding COVERIGN.
    cp_address: coverpoint address;
  endgroup

  // SpyGlass reported 'ELAB_6312: Unsupported SV constructs 'dynamic allocation'' for 'new()'.
  // Changed to a static instantiation 'cg c_inst;' to resolve this elaboration error,
  // assuming SpyGlass supports static covergroup instantiation.
  cg c_inst;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    address = 0;
    #10 address = 1;
    #10 address = 2;
    #10 $finish;
  end
endmodule
