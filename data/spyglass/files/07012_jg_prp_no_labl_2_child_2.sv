module unlabeled_assume_example (
  input clk,
  input rst_n,
  input req,
  input ack
);

  // Dummy assignments to resolve W240 (unused input) violations
  wire dummy_req_read = req;
  wire dummy_ack_read = ack;

  always @(posedge clk) begin
    if (!rst_n) begin
      // Reset logic
    end else begin
      REQ_ACK_ASSUMPTION: assume property (@(posedge clk) req |=> ack);
    end
  end

endmodule
