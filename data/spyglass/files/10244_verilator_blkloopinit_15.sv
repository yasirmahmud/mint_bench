module top15;
  logic [7:0] data[0:3];
  initial begin
    automatic int k = 0;
    for (int i = 0; i < 4; i++) begin
      data[i] <= 8'h33 + k;
      k++;
    end
  end
endmodule
