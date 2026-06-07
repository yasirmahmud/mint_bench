module latch_w422l_ex1(input d, input en1, input en2, output reg q);
 always @(en1 or en2 or d) if (en1 || en2) q = d;
 endmodule
