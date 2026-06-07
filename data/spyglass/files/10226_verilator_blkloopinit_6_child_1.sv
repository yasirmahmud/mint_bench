module top6;
  bit clk;
  logic [7:0] data[0:3];
  always_ff @(posedge clk) begin
    for (int i = 0; i < 4; i++) begin
      data[i] <= 8'hDD;
    end
  end
  initial forever #1 clk = !clk;
endmodule
