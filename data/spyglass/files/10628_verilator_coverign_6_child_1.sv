module test_iff_3;
  logic clk;
  logic [0:0] status;
  logic reset_n;

  covergroup cg @(posedge cllk);
    cp_status: coverpoint status iff (~reset_n);
  endgroup

  cg c_inst; // Changed from 'cg c_inst = new();' to 'cg c_inst;' to resolve ELAB_6312 regarding unsupported dynamic allocation for static covergroup instantiation, while maintaining functional equivalence.

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
