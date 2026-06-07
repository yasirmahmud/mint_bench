module LatchFeedback_ex2 (input en, output q_out);
 reg q1, q2;
 always @* begin if (en) q1 = q2;
 end always @* begin if (en) q2 = q1;
 end assign q_out = q1;
 endmodule
