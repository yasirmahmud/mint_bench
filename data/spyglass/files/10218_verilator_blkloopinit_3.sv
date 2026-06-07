module top3;
  logic [7:0] data[0:3][0:3];
  initial begin
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        data[i][j] <= 8'hCC;
      end
    end
  end
endmodule
