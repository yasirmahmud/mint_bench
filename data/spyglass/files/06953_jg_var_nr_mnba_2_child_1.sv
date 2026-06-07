module multiple_nba_2 (
  input clk,
  input rst_n,
  input sel,
  input data_in1,
  input data_in2,
  output logic result
);

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    result <= 1'b0;
  end else begin
    // The original code had multiple non-blocking assignments to 'result'
    // within the same always block. The assignment 'result <= data_in2;'
    // was always executed last, effectively overwriting 'result <= data_in1'
    // if 'sel' was true. Thus, 'result' always assumed the value of 'data_in2'
    // when not in reset. This corrected code explicitly implements that
    // observed functional behavior, resolving the multiple assignment violation.
    result <= data_in2;
  end
end

endmodule
