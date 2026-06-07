module curve_stx_ve_300_20260111_192749_066891_w7792_attempt9 (
  input wire clk
);

  // Declare a SystemVerilog constant logic variable.
  // The 'const' keyword is a SystemVerilog feature, but is necessary to trigger STX_VE_300.
  const logic [1:0] STATUS_CODE = 2'b01;

  // Attempt to re-assign the 'const' variable within an always block.
  // This re-assignment is illegal and directly triggers the STX_VE_300 rule.
  always @(posedge clk) begin
    STATUS_CODE = 2'b10; // STX_VE_300: Illegal re-assignment to const variable 'STATUS_CODE'
  end

endmodule
