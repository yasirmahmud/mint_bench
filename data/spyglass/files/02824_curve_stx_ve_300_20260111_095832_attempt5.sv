module curve_stx_ve_300_20260111_095832_attempt5 (
  input wire clk,
  output wire [7:0] status_out
);

  // Declare a constant register variable. The 'const' keyword is a SystemVerilog feature
  // necessary to trigger the STX_VE_300 violation, despite the 'Verilog-2001' constraint.
  // 'reg' is a Verilog-2001 keyword, chosen for minimal deviation from Verilog-2001 syntax where possible.
  const reg [7:0] my_status_const = 8'h11; // Initial constant value

  // Attempt to re-assign the constant variable within a positive-edge triggered
  // synchronous procedural block. This is an illegal operation for a 'const' variable
  // and is designed to trigger the STX_VE_300 violation exactly once.
  always @(posedge clk) begin
    my_status_const = 8'hFF; // ILLEGAL: Re-assignment to 'const' variable 'my_status_const'
  end

  // Use the constant value to prevent potential 'unused' warnings for 'my_status_const'.
  assign status_out = my_status_const;

endmodule
