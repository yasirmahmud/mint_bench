module zero_replication_multiplier (
  output wire [7:0] out_data
);
  wire [3:0] in_vec = 4'b0101;
  // Replication multiplier is zero (0)
  assign out_data = {0{in_vec}};
endmodule
