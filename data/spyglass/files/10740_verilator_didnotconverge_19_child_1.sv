module osc19;
  wire a, b, c;
  assign c = 1'b1;
  assign a = 1'b0; // Break the combinational loop by assigning a stable value to 'a'
  assign b = a;    // 'b' now follows 'a' without forming a loop
endmodule
