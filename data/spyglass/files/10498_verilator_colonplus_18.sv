module test18;
  reg [31:0] memory_block [0:10];
  reg [7:0] current_byte;
  always @(posedge clk) begin
    current_byte <= memory_block[5][8 :+ 8];
  end
  reg clk;
  initial begin clk=0; forever #10 clk=~clk; end
endmodule
