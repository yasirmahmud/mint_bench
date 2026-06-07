module unnamed_gen_if_example (
  input wire enable_feature,
  input wire a,
  input wire b,
  output wire y
);

  generate
    if (enable_feature) begin
      assign y = a & b;
    end else begin
      assign y = a | b;
    end
  endgenerate

endmodule
