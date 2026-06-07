module test13;
  reg [31:0] fifo_data;
  reg [7:0] read_byte;
  always @(posedge clk) begin
    read_byte <= fifo_data[0 :+ 8];
  end
  reg clk;
  initial begin clk=0; forever #10 clk=~clk; end
endmodule
