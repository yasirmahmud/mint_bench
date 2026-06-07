module my_module_ex2(input [1:0] in, output [7:0] out);
  reg [7:0] arr [0:3];
  reg [1:0] idx;

  // Initialize the 'arr' array with constant values.
  // This resolves UndrivenInTerm-ML and W123 violations for 'arr',
  // making it synthesizable as a ROM (Read-Only Memory).
  initial begin
    arr[0] = 8'h00;
    arr[1] = 8'h11;
    arr[2] = 8'h22;
    arr[3] = 8'h33;
  end

  // Drive 'idx' from the input 'in'.
  // This resolves:
  // - SYNTH_5143 (the problematic initial block for idx is removed)
  // - UndrivenInTerm-ML for 'idx'
  // - NoAssignX-ML (the 'x' assignment is removed)
  // - W240 (input 'in' is now read)
  assign idx = in;

  // Output assignment remains the same, reading from the 'arr' ROM based on 'idx'.
  assign out = arr[idx];
endmodule
