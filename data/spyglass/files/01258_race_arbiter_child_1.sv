module race_arbiter(finished1, finished2, reset, out, done);
  input reset, finished1, finished2;
  output out;
  output done;

  wire cnt1_done, cnt2_done;
  
  // Original assignments for cnt1_done and cnt2_done created a combinational loop.
  //   assign cnt1_done = (finished1 & ~ cnt2_done);
  //   assign cnt2_done = (finished2 & ~ cnt1_done);
  // To resolve the loop and implement mutual exclusion with priority,
  // we assume finished1 has higher priority, as implied by the structure
  // if it were a latch or priority encoder.
  assign cnt1_done = finished1;
  assign cnt2_done = finished2 & ~finished1; // finished1 has priority
  
  // The original definition for 'winner' (cnt1_done | ~ cnt2_done)
  // would result in 'winner' being high even when no finish occurred (cnt1_done=0, cnt2_done=0).
  // The design description states "generating 'out' outputs when either finish occurs",
  // implying 'out' should be low if no finish occurs.
  // Given 'out' is active high when finished1 wins (as per original interpretation),
  // we redefine 'winner' to be high only when finished1 is the determined winner.
  wire winner = cnt1_done; // 'winner' is high if finished1 wins, low otherwise.
  
  assign done = (finished1 | finished2) & ~reset;
  assign out  = winner & ~reset;

endmodule
