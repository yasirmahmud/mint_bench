module curve_starc05_2_10_1_4a_20260111_195933_071951_w36056_attempt7 (
  input wire [1:0] data_in,
  output reg        is_z_flag
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // In synthesizable hardware, an input signal cannot logically be in a 'z' (high-impedance) state.
  // Therefore, the condition 'data_in[0] === 1'bz' would always evaluate to false in synthesized hardware.
  // To preserve the functional behavior as it would appear in a physical implementation and resolve
  // the violations related to comparing with 'z' or using the '===' operator, 'is_z_flag' is 
  // assigned '0', reflecting that a 'z' state is not detectable as a valid logic level.
  always @* begin
    is_z_flag = 1'b0;
  end

endmodule
