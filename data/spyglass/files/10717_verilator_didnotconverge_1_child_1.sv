module osc1;
  wire a;
  assign a = 1'b0; // Fixed: Removed the combinational loop by assigning a stable value.
endmodule
