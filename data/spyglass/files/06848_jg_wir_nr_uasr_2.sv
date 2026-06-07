module unassigned_wire_to_output (
  output logic out_signal
);
  wire internal_unassigned_wire;

  assign out_signal = internal_unassigned_wire; // internal_unassigned_wire is read
  // internal_unassigned_wire is never assigned
endmodule
