module top18;
  logic [7:0] data[0:3][0:3][0:3];
  initial begin
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        for (int k = 0; k < 4; k++) begin
          data[i][j][k] <= 8'h66;
        end
      end
    end
  end
endmodule
