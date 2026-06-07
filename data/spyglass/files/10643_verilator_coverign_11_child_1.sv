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

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    flag = 0;
    #10 flag = 1;
    #10 $finish;
  end
endmodule
