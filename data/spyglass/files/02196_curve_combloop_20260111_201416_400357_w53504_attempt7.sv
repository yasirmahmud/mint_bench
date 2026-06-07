module curve_combloop_20260111_201416_400357_w53504_attempt7 (
  input  in_data,
  output out_data
);

  reg loop_feedback;

  // This always_comb block creates a combinational loop.
  // The value of 'loop_feedback' on the LHS depends directly on its own value
  // on the RHS through an inverter, leading to an unstable oscillating condition
  // and triggering a combinational loop violation during linting/synthesis.
  always @* begin
    loop_feedback = ~loop_feedback;
  end

  // Use both 'loop_feedback' and 'in_data' to prevent unused signal warnings.
  assign out_data = loop_feedback ^ in_data;

endmodule
