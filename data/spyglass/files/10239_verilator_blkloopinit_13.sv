module top13;
  bit [7:0] data[0:3];
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] <= 8'h11;
    end
  end
endmodule
