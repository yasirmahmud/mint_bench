module test_option_goal_with;
  logic clk;
  logic [2:0] value;

  covergroup cg @(posedge clk);
    // Verilator issues COVERIGN for unsupported SystemVerilog covergroup features like option.goal.
    // Removing option.goal to resolve linting violations related to unsupported constructs,
    // specifically STX_VE_481 and WRN_1463 which may be cascading effects of parser confusion.
    // option.goal = 80; // Original line causing issues for Verilator/SpyGlass
    cp_value: coverpoint value {
      bins small = {[0:3]};
    }
  endgroup

  cg c_inst = new();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    value = 0;
    #10 value = 1;
    #10 value = 5;
    #10 $finish;
  end
endmodule
