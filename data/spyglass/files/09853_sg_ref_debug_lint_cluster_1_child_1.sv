module my_module_ex1 (output wire out_data);
 wire undriven_a;
 wire undriven_b;
 assign undriven_a = 1'bx; // Fix: Explicitly assign undriven_a to 'X' to resolve W123
 assign undriven_b = undriven_a;
 assign out_data = undriven_b;
 endmodule
