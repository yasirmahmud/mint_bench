module unassigned_wire_to_reg (
  input clk
);
  wire my_unassigned_wire;
  reg  my_reg;

  always @(posedge clk) begin
    my_reg <= my_unassigned_wire; // my_unassigned_wire is read
  end
  // my_unassigned_wire is never assigned
endmodule
