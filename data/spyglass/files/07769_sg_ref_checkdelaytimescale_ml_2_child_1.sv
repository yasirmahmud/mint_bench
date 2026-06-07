`timescale 1ns/1ns

module my_module_ex2(
  output reg a
);

  initial begin
    #1 a = 1;
  end

endmodule
