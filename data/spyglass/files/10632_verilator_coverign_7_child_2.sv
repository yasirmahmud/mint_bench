module test_with_1;
  logic clk;
  logic [3:0] data_in;

  covergroup cg @(posedge clk);
    cp_data: coverpoint data_in {
      bins even = {0, 2, 4, 6, 8, 10, 12, 14};
    }
  endgroup

  cg c_inst; // Removed dynamic allocation to resolve ELAB_6312

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    data_in = 0;
    #10 data_in = 1;
    #10 data_in = 2;
    #10 data_in = 3;
    #10 $finish;
  end
endmodule
