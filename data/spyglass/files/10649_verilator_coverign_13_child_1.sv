module test_option_goal_1;
  logic clk;
  logic [1:0] sig;

  covergroup cg @(posedge clk);
    option.goal = 90;
    cp_sig: coverpoint sig;
  endgroup

  cg c_inst();

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
