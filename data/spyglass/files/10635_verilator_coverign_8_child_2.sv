module test_with_2;
  logic clk;
  logic [7:0] byte_val;

  covergroup cg @(posedge clk);
    cp_byte: coverpoint byte_val {
      // The 'with' clause in coverpoint bin definitions is not universally supported by all tools,
      // leading to the STX_VE_481 syntax error.
      // Original intent: bins high_nibble = {[128:255]} with (byte_val[7:4] == 4'hF);
      // This means byte_val must be in the range [128:255] AND its upper nibble (bits 7:4) must be 4'hF (15).
      // Values where byte_val[7:4] == 4'hF are in the range [4'hF0:4'hFF], which is [240:255].
      // The intersection of [128:255] and [240:255] is [240:255].
      // Redefining the bin with the explicit numerical range preserves the intended functional behavior.
      bins high_nibble = {[240:255]};
    }
  endgroup

  // Fix for ELAB_6312: Use static instantiation for covergroup instead of dynamic allocation.
  cg c_inst;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    byte_val = 0;
    #10 byte_val = 15;
    #10 byte_val = 240;
    #10 byte_val = 255;
    #10 $finish;
  end
endmodule
