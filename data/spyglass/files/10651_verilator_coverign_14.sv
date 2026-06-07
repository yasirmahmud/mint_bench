module test_option_goal_2;
  logic clk;
  logic [0:0] flag;

  covergroup cg @(posedge clk);
    option.goal = 100;
    cp_flag: coverpoint flag;
  endgroup

  cg c_inst = new();

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
