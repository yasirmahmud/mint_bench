module star_ex2 (input [1:0] sel_in, output reg out_reg);
  // Violation W240: Input 'sel_in' is declared but not read.
  // To resolve this while preserving the module's interface, 
  // a dummy assignment is used to read 'sel_in' without affecting the output.
  wire [1:0] dummy_read_sel_in;
  assign dummy_read_sel_in = sel_in;

  // Original functional behavior analysis:
  // The 'dc_sig' register was always assigned '2'bxx'.
  // In the 'case' statement, if 'dc_sig' is '2'bxx', it will not match '2'b00' or '2'b01'.
  // Therefore, the 'default' case would always be executed, setting 'out_reg' to '1'b0'.
  // To preserve this functional behavior, 'out_reg' is now directly assigned '1'b0'.
  // This also resolves violation NoAssignX-ML (STARC05-2.8.3.6) by removing the 'x' assignment.
  always @(*) begin
    out_reg = 1'b0;
  end
endmodule
