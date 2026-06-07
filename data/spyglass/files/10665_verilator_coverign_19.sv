module test_option_weight_iff;
  logic clk;
  logic [1:0] state;
  logic active;

  covergroup cg @(posedge clk);
    option.weight = 7;
    cp_state: coverpoint state iff (active);
  endgroup

  cg c_inst = new();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    active = 0; state = 0;
    #10 active = 1; state = 1;
    #10 $finish;
  end
endmodule
