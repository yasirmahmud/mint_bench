module incomplete_case_9;
  reg [1:0] cfg_sel; // Renamed 'config' to 'cfg_sel' to avoid Verilog 2001 keyword conflict
  reg ready;
  always @* begin
    case (cfg_sel)
      2'b10: ready = 1'b1;
      2'b01: ready = 1'b0;
      default: ready = 1'b0; // Added default case to cover all possible input patterns and prevent latches
    endcase
  end
endmodule
