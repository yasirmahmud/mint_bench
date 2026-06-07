module top20;
  logic [7:0] data[0:3];
  initial begin
    int i = 0;
    while (i < 4) begin
      data[i] <= 8'h88;
      i++;
    end
  end
endmodule
