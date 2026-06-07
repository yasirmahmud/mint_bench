module MuxKeyWithDefault #(parameter NR_KEY = 2, parameter KEY_LEN = 1, parameter DATA_LEN = 1) (
  output [DATA_LEN-1:0] out,
  input [KEY_LEN-1:0] key,
  input [DATA_LEN-1:0] default_out,
  input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut
);
  // Instantiate the MuxKeyInternal module. The 4th parameter, MATCH_EN, is hardcoded to 1
  // as per the original instantiation, meaning key matching is always performed.
  MuxKeyInternal #(NR_KEY, KEY_LEN, DATA_LEN, 1) i0 (out, key, default_out, lut);
endmodule
