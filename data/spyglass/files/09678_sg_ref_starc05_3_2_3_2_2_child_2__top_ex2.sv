module top_ex2;
  wire [2:0] a_sig = 3'b0; // Replaced 'reg' and 'initial' block to resolve SYNTH_5143, maintaining a_sig at 0

  sub_ex2 inst_ex2 (
    .in_port({2'b0, a_sig}), // Actual width is 5, matches updated sub_ex2 port
    .dummy_out() // Output port left unconnected as it's not used in top_ex2, resolving W528
  );
endmodule
