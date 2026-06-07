module SelfModifyingSensitivity2;
  reg data_in;
  reg data_out;

  always @(data_out or data_in) begin // 'data_out' is in sensitivity list
    data_out = data_in;             // 'data_out' is modified inside the block
  end

endmodule
