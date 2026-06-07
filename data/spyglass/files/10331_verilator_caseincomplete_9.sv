module incomplete_case_9;
  reg [1:0] config;
  reg ready;
  always @* begin
    case (config)
      2'b10: ready = 1'b1;
      2'b01: ready = 1'b0;
    endcase
  end
endmodule
