module my_module (
  input clk
);
  logic my_rand_signal; // Renamed 'rand' to avoid conflict with SystemVerilog reserved word.
  assign my_rand_signal = clk;
endmodule
