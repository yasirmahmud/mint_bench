module star_ex2(input [2:0] data_in, output reg out_reg);
 always @* begin
  // SpyGlass rule STARC05-2.10.1.4a and SYNTH_5034 state that comparing with 'x'
  // using the '==' operator will always evaluate to false in synthesis.
  // Therefore, the original 'if (data_in == 3'bxxx)' condition would always be false,
  // leading to 'out_reg' always being assigned 1'b0 in synthesizable hardware.
  // To preserve this synthesizable functional behavior and resolve the violations,
  // we explicitly assign out_reg to 1'b0.
  out_reg = 1'b0;
 end
endmodule
