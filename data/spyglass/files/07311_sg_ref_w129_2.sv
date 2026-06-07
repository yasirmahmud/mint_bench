module W129_ex2;
 reg [7:0] delay_val;
 wire out;
 reg in;
 initial begin delay_val = 5;
 in = 0;
 #10 in = 1;
 end assign #(delay_val) out = in;
 endmodule
