module block_naming_violation_2 (
  input wire enable,
  output reg status_flag
);

  initial begin : setup_sequence
    status_flag = 1'b0;
    #10 enable = 1'b1;
    #20 status_flag = 1'b1;
  end

endmodule
