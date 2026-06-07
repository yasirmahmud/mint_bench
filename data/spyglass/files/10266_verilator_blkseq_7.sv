module blkseq_ex7 (
  input clk,
  input load,
  input [2:0] count_in,
  output reg [2:0] counter
);

  always_ff @(posedge clk) begin
    if (load) begin
      counter = count_in; // Triggers BLKSEQ
    end else begin
      counter = counter + 1;
    end
  end

endmodule
