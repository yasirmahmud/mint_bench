module negative_assign_ex2 (
  output [7:0] out_data
);
  // Original: reg [7:0] data;
  // Original: initial begin data = -5; end

  // Fix SYNTH_5143: Remove initial block as it's ignored for synthesis.
  // Address STARC05-2.10.4.6: Explicitly define the width and sign of the constant.
  // -5 in 8-bit two's complement is 8'b11111011 (8'hFB).
  reg [7:0] data = 8'sh-5;

  // Fix W528: Variable 'data' set but not read. Make it an output to be readable.
  assign out_data = data;
endmodule
