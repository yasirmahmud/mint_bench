module curve_starc05_2_10_1_4b_20260111_094016_attempt1 (
  input  wire [1:0]  data_in,
  output reg         flag_out
);

  always @(*) begin
    // STARC05-2.10.1.4b: Signal 'data_in[0]' is compared with a value containing 'x'
    if (data_in[0] === 1'bx) begin
      flag_out = 1'b1;
    end else begin
      flag_out = 1'b0;
    end
  end

endmodule
