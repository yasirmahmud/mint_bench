module sim_race05_ex1;
 reg data;
 wire dummy_read;

 // Fix W528: Variable 'data' set but not read.
 // An explicit read in a synthesizable context ensures the variable is considered used.
 assign dummy_read = data;

 // Preserve sim_race05 behavior (race condition in initial blocks for simulation)
 // and fix SYNTH_5143 (Initial block is ignored for synthesis) by using `ifndef SYNTHESIS.
 `ifndef SYNTHESIS
 initial begin
  data = 1'b0;
 end
 `endif

 `ifndef SYNTHESIS
 initial begin
  $display("Data at time zero: %b", data);
 end
 `endif
endmodule
