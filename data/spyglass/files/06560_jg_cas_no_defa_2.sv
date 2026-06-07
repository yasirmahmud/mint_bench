module wide_case_no_default_2 (
  input logic [63:0] control_signal,
  output logic result
);

always_comb begin
  case (control_signal)
    64'h0000000000000001: result = 1'b0;
    64'h0000000000000002: result = 1'b1;
    64'h0000000000000003: result = 1'b0;
    // No default statement
  endcase
end

endmodule
