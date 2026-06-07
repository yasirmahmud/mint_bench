module LOP_NR_SRLG_while (
  input clk,
  input rst_n,
  input [7:0] data_in,
  output reg [7:0] q_out
);

  integer j;

  always_ff @(posedge clk or negedge rst_n) begin
    j = 0;
    while (j < 8) begin // Reset and logic in the same while loop
      if (!rst_n) begin
        q_out[j] <= 1'b0;
      end else begin
        q_out[j] <= data_in[j];
      end
      j = j + 1;
    end
  end

endmodule
