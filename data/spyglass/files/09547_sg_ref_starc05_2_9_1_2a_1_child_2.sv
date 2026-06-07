module star_c05_2_9_1_2a_ex1(input [7:0] data_in);
 reg [7:0] result;

 // Replaced the for-loop with equivalent combinational logic to resolve
 // SYNTH_5230 error. This preserves the functional behavior as described.
 // The 'integer i;' declaration is removed as it is no longer used.
 always @(*) begin
  if (data_in[3:0] < 10) begin
   result = 10 - data_in[3:0];
  end else begin
   result = 8'h00;
  end
 end
endmodule
