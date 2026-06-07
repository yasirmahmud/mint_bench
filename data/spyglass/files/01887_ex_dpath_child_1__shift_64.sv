module shift_64(out, msw_in, lsw_in, count, dir, arith, word_sel);
  output [31:0] out;
  input  [31:0] msw_in;
  input  [31:0] lsw_in;
  input  [5:0]  count;
  input         dir;
  input         arith;
  input         word_sel; // 1: MSW, 0: LSW

  wire [63:0] full_in = {msw_in, lsw_in};
  wire [63:0] shifted_val;

  assign shifted_val = dir ?
                       (arith ? ($signed(full_in) >>> count) : (full_in >> count)) :
                       (full_in << count);

  assign out = word_sel ? shifted_val[63:32] : shifted_val[31:0];
endmodule
