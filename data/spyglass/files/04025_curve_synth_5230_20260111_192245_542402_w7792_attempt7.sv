module curve_synth_5230_20260111_192245_542402_w7792_attempt7 (
  output reg [31:0] out_data
);

  integer i;
  reg [31:0] temp_val;

  always @(*) begin
    temp_val = 0;
    out_data = 0;

    // SYNTH_5230: Number of iterations in for-loop exceeds max. allowable limit (2048).
    // This loop iterates 2049 times (i from 0 to 2048).
    for (i = 0; i < 2049; i = i + 1) begin
      temp_val = temp_val + 1;
      out_data = temp_val;
    end
  end

endmodule
