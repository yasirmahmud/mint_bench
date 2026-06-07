module curve_synth_5230_20260111_192245_542402_w7792_attempt8 (
  input wire [7:0] in_data,
  output reg [31:0] out_data
);

  integer i;
  reg [31:0] local_reg;

  always @(*) begin
    local_reg = 0; // Initialize local_reg
    out_data = 0;  // Initialize out_data

    // SYNTH_5230: Number of iterations in for-loop exceeds max. allowable limit (2048).
    // This loop iterates 2049 times (i from 0 to 2048), triggering the violation.
    for (i = 0; i < 2049; i = i + 1) begin
      // Perform a conditional assignment only on the last iteration to avoid W415a.
      // 'local_reg' is only effectively assigned once within the loop's context.
      if (i == 2048) begin
        local_reg = i + in_data;
      end
    end

    // Assign the final computed value to the output once, after the loop.
    out_data = local_reg;
  end

endmodule
