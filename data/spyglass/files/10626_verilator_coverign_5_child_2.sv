module test_iff_2;
  logic clk;
  logic [2:0] value;
  logic active;

  covergroup cg @(posedge clk);
    cp_value: coverpoint value;
  endgroup c_inst; // Statically instantiate the covergroup

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    active = 0;
    value = 0;
    #10 active = 1;
    value = 1;
    #10 value = 2;
    #10 active = 0;
    value = 3;
    #10 $finish;
  end
endmodule
