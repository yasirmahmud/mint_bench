module test_iff_with;
  logic clk;
  logic [3:0] data;
  logic valid;

  covergroup cg @(posedge clk);
    cp_data: coverpoint data iff (valid) {
      bins even_data = {0, 2, 4, 6, 8, 10, 12, 14};
    }
  endgroup

  // SpyGlass ELAB_6312 "Unsupported SV constructs 'dynamic allocation'" was reported
  // for 'cg c_inst = new();'. Separating the declaration and instantiation into
  // an initial block resolves this error by making the allocation explicitly
  // procedural, which is more robust for certain EDA tools.
  cg c_inst; // Declare the covergroup instance

  initial begin // Instantiate the covergroup in an initial block
    c_inst = new();
  end

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
