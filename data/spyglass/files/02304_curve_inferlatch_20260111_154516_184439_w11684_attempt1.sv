module infer_latch_example (
  input wire enable,
  input wire data_in,
  output reg latch_q
);

  always @(enable or data_in) begin
    if (enable) begin
      latch_q = data_in;
    end
    // If 'enable' is low, 'latch_q' is not assigned,
    // implying it holds its previous value, thus inferring a latch.
  end

endmodule
