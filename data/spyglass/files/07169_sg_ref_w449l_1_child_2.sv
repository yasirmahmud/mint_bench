module latch_w449l_ex1 (input enable_in, data_in, output reg q_out);
  always @(enable_in or data_in) begin
    if (~enable_in) begin
      q_out <= data_in;
    end
    // In the else case (enable_in is high), q_out is not explicitly assigned.
    // This infers a latch where q_out holds its previous value.
    // This resolves the W122 violation by removing the read of 'q_out' within the block
    // when 'q_out' is not in the sensitivity list, while preserving the latch behavior.
  end
endmodule
