module curve_wrn_1470_20260111_221758_569112_w28836_attempt12 (
  input wire in_x,
  input wire in_y,
  input wire in_a,
  input wire in_b,
  input wire in_c,
  input wire in_d,
  output reg [3:0] out_vec0,
  output reg [2:0] out_vec1,
  output reg [4:0] out_vec2
);

  // WRN_1470 #1: This procedural assignment uses an array pattern with explicit integer keys
  // (1, 3) and a 'default' key. This is a SystemVerilog construct not supported in Verilog-2001.
  always @(*) begin
    out_vec0 = '{1: in_x, 3: in_y, default: 1'b0};
  end

  // WRN_1470 #2: A second distinct instance of the unsupported array pattern key construct.
  // It assigns to a different width vector and uses an input for the default value.
  always @(*) begin
    out_vec1 = '{0: in_a, default: in_b};
  end

  // WRN_1470 #3: A third instance, varying the target vector width, specific keys (4, 2),
  // and constant default value, all within an always block.
  always @(*) begin
    out_vec2 = '{4: in_c, 2: in_d, default: 1'b1};
  end

endmodule
