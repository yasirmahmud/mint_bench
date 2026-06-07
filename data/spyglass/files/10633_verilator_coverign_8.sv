module test_with_2;
  logic clk;
  logic [7:0] byte_val;

  covergroup cg @(posedge clk);
    cp_byte: coverpoint byte_val {
      bins high_nibble = {[128:255]} with (byte_val[7:4] == 4'hF);
    }
  endgroup

  cg c_inst = new();

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
