module curve_stx_ve_481_20260111_155918_071333_w30032_attempt1 (
  input wire in_a,
  output reg out_b
);

always @* begin
  if (in_a) begin
    out_b = 1'b1;
  end
  else // This 'else' is valid, matching the 'if (in_a)'
    out_b = 1'b0;
  // The following 'else' is illegal as it has no preceding 'if' clause to attach to,
  // directly causing a syntax error related to the 'else' keyword.
  else
    out_b = 1'b0;
end

endmodule
