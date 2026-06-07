module large_delay_range_seq (
  input clk,
  input rst_n,
  input start_event,
  input end_event
);

  sequence s_long_wait;
    start_event ##[0:1500] end_event;
  endsequence

  ap_long_wait: assert property (@(posedge clk) disable iff (!rst_n) s_long_wait);

endmodule
