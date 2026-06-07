module test_option_weight_1;
  logic clk;
  logic [1:0] sig;

  covergroup cg @(posedge clk);
    option.weight = 10;
    cp_sig: coverpoint sig;
  endgroup

  cg c_inst = new();

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
