module b_recoder (mag_a, mag_b, nxt_rbb10, cur_rbb1,
                  sel_swap,  cyc_compare, 
                  clr, clk,
                  nxt_booth_0, booth_2, booth_neg);

input   [1:0]  mag_a;
input   [1:0]  mag_b;
input   [1:0]  nxt_rbb10;         //  may just use cur_rbb[3:2]
input          cur_rbb1;
input          sel_swap;
input          cyc_compare;
input          clr;
input          clk;
output         nxt_booth_0;
output         booth_2;
output         booth_neg;

wire           booth_0; // Declared but unused in the original code, kept for consistency if it was intended for future use.
wire           booth_2, booth_neg;
wire    [1:0]  inp_b;
wire           nxt_booth_0,  nxt_booth_2,  nxt_booth_neg;

wire           a_b0, a_b2, a_neg;
wire           b_b0, b_b2, b_neg;

  booth booth_a (
                 .inp(mag_a),
                 .inp_pre(1'b0),
                 .b0(a_b0),
                 .b1(),
                 .b2(a_b2),
                 .neg(a_neg) 
                );

  assign inp_b = cyc_compare ? mag_b : nxt_rbb10;

  booth booth_b ( 
                 .inp(inp_b),
                 .inp_pre(cur_rbb1),
                 .b0(b_b0),
                 .b1(),
                 .b2(b_b2),
                 .neg(b_neg) 
                );

  assign nxt_booth_0   = !clr && (sel_swap ? a_b0  : b_b0);
  assign nxt_booth_2   = !clr && (sel_swap ? a_b2  : b_b2);
  assign nxt_booth_neg = !clr && (sel_swap ? a_neg : b_neg);

/*  Logic   
  always @ (posedge clk)
    {booth_2,booth_neg} <= (sm ? {2{sin}} : {nxt_booth_2,nxt_booth_neg});
*/

/*  gate flip-flop */
  ff_s_2 ff_s_2_a (
                   .out({    booth_2,    booth_neg}),
                   .din({nxt_booth_2,nxt_booth_neg}),
                   .clk(clk)
                  );

endmodule
