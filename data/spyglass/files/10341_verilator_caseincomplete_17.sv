module incomplete_case_17;
  reg [1:0] operation;
  reg op_done;
  always @* begin
    case (operation)
      2'd0: op_done = 1'b0;
      2'd2: op_done = 1'b1;
    endcase
  end
endmodule
