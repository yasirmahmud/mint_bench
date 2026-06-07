module incomplete_case_19;
  reg [0:0] clock_gate_en;
  reg clock_out;
  always @* begin
    case (clock_gate_en)
      1'b0: clock_out = 1'b0;
    endcase
  end
endmodule
