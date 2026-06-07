module unread_reg_example2 (
  input wire enable,
  input wire value_in
);

  reg another_unused_reg; // This will be assigned but not read

  always @(*) begin
    if (enable) begin
      another_unused_reg = value_in;
    end else begin
      another_unused_reg = 1'b0;
    end
  end

endmodule
