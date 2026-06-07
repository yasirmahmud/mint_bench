module curve_wrn_1470_20260111_182046_011163_w37940_attempt9 (
  input wire in_val0,
  input wire in_val1,
  output wire [2:0] out_vec
);

  // Declare a 3-bit packed register.
  reg [2:0] my_packed_reg;

  // WRN_1470: The construct 'array pattern keys in assignment patterns
  // '{ 0:val ,1:1'b0} ' is not supported in some tools.
  // This procedural assignment within an always @(*) block uses a SystemVerilog
  // assignment pattern with explicit integer keys (0, 2) and a 'default' key
  // to assign to a packed register. This construct is not supported in
  // Verilog-2001 and will trigger WRN_1470.
  always @(*) begin
    my_packed_reg = '{0: in_val0, 2: in_val1, default: 1'b0};
  end

  // Assign to output to avoid unused signal warnings for my_packed_reg
  assign out_vec = my_packed_reg;

endmodule
