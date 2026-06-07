module test_realtime_violation;
  real current_sim_time;
  initial begin
    current_sim_time = $realtime;
    $display("Simulation time: %f", current_sim_time);
  end
endmodule
