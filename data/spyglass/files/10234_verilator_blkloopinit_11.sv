module top11;
  shortint data[0:3];
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] <= i;
    end
  end
endmodule
