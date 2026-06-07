module test_option_goal_3;
  logic clk;
  logic [3:0] address;

  covergroup cg @(posedge clk);
    // option.goal = 50; // Removed to resolve Verilator COVERIGN warnings as per design description and potential tool incompatibility
    cp_address: coverpoint address;
  endgroup

  cg c_inst; // Statically instantiated to resolve ELAB_6312 (dynamic allocation unsupported)

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
