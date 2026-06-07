module star_c05_2_9_1_2a_ex1(input [7:0] data_in);
 integer i; // Changed from 'reg [3:0] i;' to 'integer i;' to fix W480
 reg [7:0] result;

 // Replaced 'initial' block with an 'always @(*)' block to make the logic synthesizable.
 // This addresses SYNTH_5143 while preserving the functional behavior of calculating 'result'
 // based on 'data_in' combinatorially.
 always @(*) begin
  result = 8'h00; // Initialize 'result' within the always block to prevent latches and match initial condition
  for (i = data_in[3:0]; i < 10; i = i + 1) begin
   result = result + 1;
  end
 end
endmodule
