module async_4bit_count  (j,k,clock,reset,q);

input j,k;
input clock,reset;
output [3:0]q;

// Internal wires for the outputs of JK FFs. These wires serve as the clock inputs for subsequent stages.
wire ff_q0, ff_q1, ff_q2, ff_q3;

// Instantiate JK flip-flops
jk_ff JK1(j,k,clock,reset,ff_q0);
jk_ff JK2(j,k,ff_q0,reset,ff_q1);
jk_ff JK3(j,k,ff_q1,reset,ff_q2);
jk_ff JK4(j,k,ff_q2,reset,ff_q3);

// Assign the internal FF outputs to the module's external output port 'q'.
// This separates the naming of the signals used for internal clocking from the output port itself,
// addressing the SpyGlass violation where 'q[2:0]' was identified as a clock signal and then
// used as a non-clock (i.e., as an output port).
assign q[0] = ff_q0;
assign q[1] = ff_q1;
assign q[2] = ff_q2;
assign q[3] = ff_q3;

endmodule
