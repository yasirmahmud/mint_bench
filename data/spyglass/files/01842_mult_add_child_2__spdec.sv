// Dummy spdec for linting (functional behavior inferred from usage)
module spdec (output [1:0] spmd, mout_dr,
              output lin, movf,
              input laovf, sti, iovf,
              input [4:0] alow,
              input [1:0] mout_sel);
  // Simple assignments for linting purposes; actual logic is complex
  assign spmd = mout_sel;
  assign lin = laovf | alow[0];
  assign movf = iovf | sti;
  assign mout_dr = mout_sel;
endmodule
