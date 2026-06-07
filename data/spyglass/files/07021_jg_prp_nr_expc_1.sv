module complex_clock_prop_1 (
  input clk_a,
  input clk_b,
  input req,
  input ack
);

  property p_req_ack;
    @(posedge (clk_a && clk_b)) req |-> ##[1:2] ack;
  endproperty

  assert property (p_req_ack) else $error("Req-Ack sequence failed");

endmodule
