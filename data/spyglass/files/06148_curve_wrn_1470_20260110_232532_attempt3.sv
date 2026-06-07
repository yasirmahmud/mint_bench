module curve_wrn_1470_20260110_232532_attempt3 (
  input wire in_bit,
  output reg [1:0] out_vec
);

  // WRN_1470: The construct 'array pattern keys in assignment patterns '{ 0:in_bit ,default:1'b0} ' is not supported in some tools
  always @(*) begin
    out_vec = '{0: in_bit, default: 1'b0};
  end

endmodule
