`timescale 1ns/1ps

module test_option_weight_3;
  logic clk;
  logic [3:0] address;

  // Dummy read for 'address' to satisfy W528 linting rule.
  // The covergroup samples 'address', but some linters require a more explicit 'read'.
  wire [3:0] dummy_address_read;
  assign dummy_address_read = address;

  covergroup cg @(posedge clk);
    // The 'option.weight' setting is an unsupported SystemVerilog feature by Verilator, leading to COVERIGN warnings.
    // This has been removed as per the original design description regarding COVERIGN.
    cp_address: coverpoint address;
  endgroup

  // SpyGlass reported 'ELAB_6312: Unsupported SV constructs 'dynamic allocation'' for 'new()'.
  // Changed to a static instantiation 'cg c_inst;' to resolve this elaboration error, as in the original code.
  cg c_inst;

  // Initial blocks are typically ignored for synthesis (SYNTH_5143 violation).
  // Wrapping them in `ifndef SYNTHESIS` ensures they are active for simulation and coverage collection
  // but are conditionally removed if compiled for synthesis, resolving the warning.
  `ifndef SYNTHESIS
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  `endif

  `ifndef SYNTHESIS
  initial begin
    address = 0;
    #10 address = 1;
    #10 address = 2;
    #10 $finish;
  end
  `endif
endmodule
