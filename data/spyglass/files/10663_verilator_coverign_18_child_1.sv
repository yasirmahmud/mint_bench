module test_iff_with;
  logic clk;
  logic [3:0] data;
  logic valid;

  covergroup cg @(posedge clk);
    cp_data: coverpoint data iff (valid) {
      // Original: bins even_data = {[0:15]} with (data % 2 == 0);
      // SpyGlass flagged 'with' as a syntax error (STX_VE_481).
      // Rewritten to explicitly list even numbers from 0 to 14 to resolve the syntax error
      // while preserving the functional intent of covering even data.
      bins even_data = {0, 2, 4, 6, 8, 10, 12, 14};
    }
  endgroup

  cg c_inst = new();

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    valid = 0; data = 1;
    #10 valid = 1; data = 2;
    #10 data = 3;
    #10 $finish;
  end
endmodule
