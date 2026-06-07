module test_iff_3;
  logic clk;
  logic [0:0] status;
  logic reset_n;

  covergroup cg @(posedge clk);
    cp_status: coverpoint status iff (~reset_n);
  endgroup

  cg c_inst = new();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset_n = 0;
    status = 0;
    #10 reset_n = 1;
    status = 1;
    #10 reset_n = 0;
    status = 0;
    #10 $finish;
  end
endmodule
