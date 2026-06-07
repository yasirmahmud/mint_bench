module test_cross_2;
  logic clk;
  logic [2:0] addr;
  logic [1:0] data;

  covergroup cg @(posedge clk);
    cp_addr: coverpoint addr;
    cp_data: coverpoint data;
    cross cp_addr, cp_data;
  endgroup

  cg c_inst = new();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    addr = 0;
    data = 0;
    #10 addr = 1;
    #10 data = 1;
    #10 addr = 2;
    #10 data = 2;
    #10 $finish;
  end
endmodule
