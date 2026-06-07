module incomplete_case_13;
  reg [1:0] prio_in; // Renamed from 'priority' to avoid SystemVerilog keyword conflict
  reg grant;
  always @* begin
    case (prio_in) // Changed to 'prio_in'
      2'b00: grant = 1'b1;
      default: grant = 1'b0; // Added default case to cover all patterns and avoid CASEINCOMPLETE warning
    endcase
  end
endmodule
