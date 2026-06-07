module unlabeled_assume_example (
  input clk,
  input rst_n,
  input req,
  input ack
);

  always @(posedge clk) begin
    if (!rst_n) begin
      // Reset logic
    end else begin
      assume property (@(posedge clk) req |=> ack);
    end
  end

endmodule
