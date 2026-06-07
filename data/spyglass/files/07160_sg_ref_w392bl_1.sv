module w392bL_ex1 (en, rst, d1, d2, q1, q2);
 input en, rst, d1, d2;
 output q1, q2;
 reg q1, q2;
 always @(en or rst or d1) begin if (en) begin if (rst) q1 <= 1'b0;
 else q1 <= d1;
 end end always @(en or rst or d2) begin if (en) begin if (~rst) q2 <= 1'b0;
 else q2 <= d2;
 end end endmodule
