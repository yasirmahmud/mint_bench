module incomplete_case_10;
  reg [2:0] status_code;
  reg error_flag;
  always @* begin
    case (status_code)
      3'd0: error_flag = 1'b0;
      3'd1: error_flag = 1'b1;
      3'd2: error_flag = 1'b0;
      3'd3: error_flag = 1'b1;
    endcase
  end
endmodule
