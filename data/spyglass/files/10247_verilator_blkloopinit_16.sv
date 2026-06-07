module top16;
  logic [7:0] data[0:3];
  initial begin
    fork
      for (int i = 0; i < 4; i++) begin
        data[i] <= 8'h44;
      end
    join
  end
endmodule
