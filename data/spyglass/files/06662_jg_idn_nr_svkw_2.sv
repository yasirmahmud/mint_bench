module my_module (
  input clk
);
  logic rand; // Using 'rand' as a signal name, which is a SystemVerilog reserved word.
  assign rand = clk;
endmodule
