module buf_a_oprd (
  input  [31:0] a_oprd_i,
  output [31:0] a_oprd,
  output [31:0] a_oprd_u,
  output [31:0] ucode_porta,
  output        a_oprd_0_l
);
  assign a_oprd      = a_oprd_i;
  assign a_oprd_u    = a_oprd_i; // a_oprd_u is another version of a_oprd_i
  assign ucode_porta = a_oprd_i;
  assign a_oprd_0_l  = !a_oprd_i[0];
endmodule
