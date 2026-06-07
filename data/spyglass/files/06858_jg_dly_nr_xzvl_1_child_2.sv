`timescale 1ns/1ps
module delay_x_violation (
  output reg my_signal
);

  initial begin
    my_signal = 1'b0;
    #1 my_signal = 1'b1;
  end
endmodule
