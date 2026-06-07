module curve_wrn_1041_20260111_174155_070321_w7792_attempt6;
  reg [7:0] data_out;

  always @(*) begin
    // WRN_1041: Underscore present in the end of a numeric value will be ignored
    data_out = 8'd255_; 
  end

endmodule
