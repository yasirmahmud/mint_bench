module mx3_9 (inp1, inp2, inp3, sel, out);
 
input   [8:0]  inp1;
input   [8:0]  inp2;
input   [8:0]  inp3;
input   [1:0]  sel;
output  [8:0]  out;
 
wire    [8:0]  out;
 
mx3_1 U00 (.inp({inp3[0], inp2[0], inp1[0] }),.sel(sel),.out(out[0]));
mx3_1 U01 (.inp({inp3[1], inp2[1], inp1[1] }),.sel(sel),.out(out[1]));
mx3_1 U02 (.inp({inp3[2], inp2[2], inp1[2] }),.sel(sel),.out(out[2]));
mx3_1 U03 (.inp({inp3[3], inp2[3], inp1[3] }),.sel(sel),.out(out[3]));
mx3_1 U04 (.inp({inp3[4], inp2[4], inp1[4] }),.sel(sel),.out(out[4]));
mx3_1 U05 (.inp({inp3[5], inp2[5], inp1[5] }),.sel(sel),.out(out[5]));
mx3_1 U06 (.inp({inp3[6], inp2[6], inp1[6] }),.sel(sel),.out(out[6]));
mx3_1 U07 (.inp({inp3[7], inp2[7], inp1[7] }),.sel(sel),.out(out[7]));
mx3_1 U08 (.inp({inp3[8], inp2[8], inp1[8] }),.sel(sel),.out(out[8]));
 
endmodule
