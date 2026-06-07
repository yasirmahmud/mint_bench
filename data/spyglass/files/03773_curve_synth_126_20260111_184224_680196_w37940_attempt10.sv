module curve_synth_126_20260111_184224_680196_w37940_attempt10 (
  input in_data,
  output reg out_data
);

  reg internal_reg;

  // SYNTH_126: Procedural continuous assign statements are not synthesizable.
  // This 'assign' statement inside an 'always @*' block triggers SYNTH_126.
  always @* begin
    assign internal_reg = in_data;
  end

  // This always block ensures 'internal_reg' is used and 'out_data' is driven.
  // It does not trigger any other violations as it's a complete combinational assignment.
  always @* begin
    out_data = internal_reg;
  end

endmodule
