module top2;
  logic [0:3][7:0] data;
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] <= 8'hBB;
    end
  end
endmodule
