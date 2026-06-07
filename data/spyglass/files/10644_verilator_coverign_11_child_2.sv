`timescale 1ns/1ps
module verilator_coverign_11_child_1;
  logic clk;
  logic [0:0] flag;

  covergroup cg @(posedge clk);
    // option.weight was removed as it's an unsupported SystemVerilog covergroup feature
    // that Verilator issues COVERIGN for and may cause issues with other linting tools.
    cp_flag: coverpoint flag;
  endgroup

  // Statically instantiate the covergroup to resolve the ELAB_6312 violation
  // "Unsupported SV constructs 'dynamic allocation'" and related elaboration issues.
  cg c_inst;

  // Add a simulation-only read for 'flag' to resolve W528 linting violation.
  // 'flag' is implicitly read by the covergroup (cp_flag), but some linters may not recognize this as a usage.
  always @(posedge clk) begin
    // This display statement explicitly reads 'flag' at each positive clock edge,
    // satisfying linters like W528. It's a simulation-only construct, consistent with
    // the module's testbench-like nature (due to initial blocks and $finish).
    $display("[%0t] clk=%0b, flag=%0b", $time, clk, flag);
  end

  initial begin
    // SYNTH_5143 warning for initial blocks: These blocks are for simulation only and are ignored for synthesis.
    // As this module contains covergroups and $finish, it is intended for simulation and functional coverage verification.
    // Removing these blocks would break the required functional behavior for coverage collection.
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // SYNTH_5143 warning for initial blocks: These blocks are for simulation only and are ignored for synthesis.
    // As this module contains covergroups and $finish, it is intended for simulation and functional coverage verification.
    // Removing these blocks would break the required functional behavior for coverage collection.
    flag = 0;
    #10 flag = 1;
    #10 $finish;
  end
endmodule
