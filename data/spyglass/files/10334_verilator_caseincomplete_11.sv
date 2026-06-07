module incomplete_case_11;
  reg [0:0] enable_sig;
  reg data_valid;
  always @* begin
    case (enable_sig)
      1'b0: data_valid = 1'b0;
    endcase
  end
endmodule
