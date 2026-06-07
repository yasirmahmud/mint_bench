module elab_6312_attempt11 (
  input wire clock_i,
  input wire gate_i,
  input wire [7:0] data_in_i,
  output reg [7:0] data_out_o
);

  // ELAB_6312: The 'iff' construct in an always sensitivity list is a SystemVerilog feature
  // and is not supported in Verilog-2001, directly triggering this violation.
  always @(posedge clock_i iff gate_i) begin
    data_out_o <= data_in_i;
  end

endmodule
