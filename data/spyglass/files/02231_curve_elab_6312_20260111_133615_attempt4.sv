module curve_elab_6312_20260111_133615_attempt4 (
  input wire clock_in,
  input wire enable_condition,
  input wire data_in,
  output reg data_out
);

  // This 'iff' construct in the sensitivity list is a SystemVerilog feature
  // and is not supported in Verilog-2001. This will trigger an ELAB_6312 violation.
  // Using 'negedge' makes this example distinct from previous attempts that used 'posedge'.
  always @(negedge clock_in iff enable_condition) begin
    data_out <= data_in;
  end

endmodule
