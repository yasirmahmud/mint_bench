module SignedBitPartSelect_ex2 (
  output wire [0:0] bit_val
);
  reg signed [7:0] data_s;

  initial begin
    data_s = 8'd0; // Initialize data_s to resolve the 'never set' error
  end

  assign bit_val = data_s[0];

endmodule
