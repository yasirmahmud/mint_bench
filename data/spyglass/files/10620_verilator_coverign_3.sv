module test_cross_3;
  logic clk;
  logic enable;
  logic [0:0] state;

  covergroup cg @(posedge clk);
    cp_enable: coverpoint enable;
    cp_state: coverpoint state;
    cross cp_enable, cp_state;
  endgroup

  cg c_inst = new();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    enable = 0;
    state = 0;
    #10 enable = 1;
    #10 state = 1;
    #10 $finish;
  end
endmodule
