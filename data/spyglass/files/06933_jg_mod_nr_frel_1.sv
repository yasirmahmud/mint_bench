module force_example_1 (
  input wire clk,
  input wire rst,
  output reg my_signal
);

  initial begin
    #10 force my_signal = 1'b1;
  end

endmodule
