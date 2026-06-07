module curve_wrn_1470_20260111_182046_011163_w37940_attempt7 (
  input wire [1:0] in_data,
  output wire [1:0] out_data
);

  // Declare a 2-element array of 2-bit registers
  reg [1:0] my_reg_array [0:1];

  // WRN_1470: The construct 'array pattern keys in assignment patterns
  // '{ 0:val ,1:1'b0} ' is not supported in some tools.
  // This assignment uses an array pattern with explicit integer keys,
  // which is a SystemVerilog feature and will trigger WRN_1470
  // when compiled under Verilog-2001.
  always @(*) begin
    my_reg_array = '{0: in_data, 1: 2'b01};
  end

  // Assign to output to avoid unused signal warnings for my_reg_array
  assign out_data = my_reg_array[0];

endmodule
