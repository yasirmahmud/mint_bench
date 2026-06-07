module test_option_goal_with;
  logic clk;
  logic [2:0] value;

  covergroup cg @(posedge clk);
    option.goal = 80;
    cp_value: coverpoint value {
      bins small = {[0:3]} with (value < 4);
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
