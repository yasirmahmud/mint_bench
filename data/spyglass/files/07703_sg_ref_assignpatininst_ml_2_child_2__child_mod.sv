module child_mod (input [7:0] p_data [0:1]);
  // Dummy logic to use p_data and resolve W240 and WarnAnalyzeBBox
  wire [7:0] internal_p_data_0;
  wire [7:0] internal_p_data_1;

  assign internal_p_data_0 = p_data[0];
  assign internal_p_data_1 = p_data[1];
 endmodule
