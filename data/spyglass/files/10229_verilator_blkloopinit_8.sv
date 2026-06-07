module top8;
  logic [7:0] data[0:3][0:3];
  initial begin
    foreach (data[i,j]) begin
      data[i][j] <= 8'hFF;
    end
  end
endmodule
