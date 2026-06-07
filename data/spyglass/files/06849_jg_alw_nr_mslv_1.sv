module SelfModifyingSensitivity1;
  reg a;
  reg b;

  always @(a) begin // 'a' is in sensitivity list
    a = b;         // 'a' is modified inside the block
  end

endmodule
