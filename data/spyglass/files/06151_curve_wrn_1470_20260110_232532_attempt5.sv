module curve_wrn_1470_20260110_232532_attempt5 (
  input wire in_bit,
  output wire [3:0] out_a,
  output wire [1:0] out_b [0:1], // Unpacked array output
  output wire [2:0] out_c
);

  reg [3:0] reg_a;
  reg [1:0] reg_b_internal [0:1]; // Unpacked array of 2-bit registers
  reg [2:0] reg_c;

  // WRN_1470 occurrence 1: Packed array assignment in always block with specific indices
  always @(*) begin
    reg_a = '{3: in_bit, 1: 1'b1, default: 1'b0};
  end

  // WRN_1470 occurrence 2: Unpacked array assignment in always block
  always @(*) begin
    reg_b_internal = '{0: 2'd2, 1: {in_bit, 1'b0}};
  end

  // WRN_1470 occurrence 3: Packed array assignment in always block with different indices and order
  always @(*) begin
    reg_c = '{0: 1'b0, 2: in_bit};
  end

  // Connect internal registers to outputs
  assign out_a = reg_a;
  genvar i;
  generate
    for (i = 0; i <= 1; i = i + 1) begin : connect_b_loop
      assign out_b[i] = reg_b_internal[i];
    end
  endgenerate
  assign out_c = reg_c;

endmodule
