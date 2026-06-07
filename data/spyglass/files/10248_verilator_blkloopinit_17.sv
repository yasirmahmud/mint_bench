module top17;
  logic [7:0] data[0:3];
  initial begin
    repeat(1) begin
      for (int i = 0; i < 4; i++) begin
        data[i] <= 8'h55;
      end
    end
  end
endmodule
