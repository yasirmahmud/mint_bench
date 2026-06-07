module curve_starc05_2_10_1_4a_20260111_195933_071951_w36056_attempt7 (
  input wire [1:0] data_in,
  output reg        is_z_flag
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // Comparing a bit of data_in with '1'bz' will trigger the violation.
  always @* begin
    if (data_in[0] === 1'bz) begin // Target violation: Signal compared with 'z'
      is_z_flag = 1'b1;
    end else begin
      is_z_flag = 1'b0;
    end
  end

endmodule
