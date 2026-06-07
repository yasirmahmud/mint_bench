module test13;
  reg [31:0] fifo_data;
  reg [7:0] read_byte;
  reg clk; // Moved declaration before usage in always block
  always @(posedge clk) begin
    read_byte <= fifo_data[0 +: 8]; // Corrected ':+' to '+:' for indexed part-select
  end
  initial begin clk=0; forever #10 clk=~clk; end
endmodule
