module LOP_NR_SRLG_for (
  input clk,
  input rst_n,
  input [3:0] data_in,
  output reg [3:0] q_out
);

  integer i;

  always_ff @(posedge clk or negedge rst_n) begin
    for (i = 0; i < 4; i = i + 1) begin // Reset and logic in the same for loop
      if (!rst_n) begin
        q_out[i] <= 1'b0;
      end else begin
        q_out[i] <= data_in[i];
      end
    end
  end

endmodule
