module syndrome_row_9(r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,
                    r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,
				r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31,
                    S,
				clk,
				reset);
//---------------------------S2--------------------------------
wire [12:0]alpha0=13'b0000000000001;
wire [12:0]alpha9=13'b0001000000000;
wire [12:0]alpha18=13'b0001101100000;
wire [12:0]alpha27=13'b0001010001010;
wire [12:0]alpha36=13'b1011110111000;
wire [12:0]alpha45=13'b0111111100101;
wire [12:0]alpha54=13'b0001100010010;
wire [12:0]alpha63=13'b0011011001011;
wire [12:0]alpha72=13'b1001100010100;
wire [12:0]alpha81=13'b1000111001011;
wire [12:0]alpha90=13'b0110000000100;
wire [12:0]alpha99=13'b0001101000000;
wire [12:0]alpha108=13'b0001010111100;
wire [12:0]alpha117=13'b1101110010101;
wire [12:0]alpha126=13'b1111010010011;
wire [12:0]alpha135=13'b1010111100011;
wire [12:0]alpha144=13'b1101011110010;
wire [12:0]alpha153=13'b1000101111001;
wire [12:0]alpha162=13'b0100011110001;
wire [12:0]alpha171=13'b0111100011001;
wire [12:0]alpha180=13'b1101110001011;
wire [12:0]alpha189=13'b0001010001000;
wire [12:0]alpha198=13'b1001110111000;
wire [12:0]alpha207=13'b0100100100101;
wire [12:0]alpha216=13'b0011000000110;
wire [12:0]alpha225=13'b0100110100000;
wire [12:0]alpha234=13'b0110011011110;
wire [12:0]alpha243=13'b1011111101111;
wire [12:0]alpha252=13'b0000110010010;
wire [12:0]alpha261=13'b0010101110011;
wire [12:0]alpha270=13'b0000100110001;
wire [12:0]alpha279=13'b0001110011101;


//-----------------------------------------------------------------------


input r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,
      r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,
	 r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,
	 r31,
	 clk,
	reset;
output [12:0]S;

wire [12:0]S;

wire [12:0]out0;
wire [12:0]out1;
wire [12:0]out2;
wire [12:0]out3;
wire [12:0]out4;
wire [12:0]out5;
wire [12:0]out6;
wire [12:0]out7;
wire [12:0]out8;
wire [12:0]out9;
wire [12:0]out10;
wire [12:0]out11;
wire [12:0]out12;
wire [12:0]out13;
wire [12:0]out14;
wire [12:0]out15;
wire [12:0]out16;
wire [12:0]out17;
wire [12:0]out18;
wire [12:0]out19;
wire [12:0]out20;
wire [12:0]out21;
wire [12:0]out22;
wire [12:0]out23;
wire [12:0]out24;
wire [12:0]out25;
wire [12:0]out26;
wire [12:0]out27;
wire [12:0]out28;
wire [12:0]out29;
wire [12:0]out30;
wire [12:0]out31;

wire [12:0]sum;
wire [12:0]feedback;

reg [12:0]d=0;
	


mux mux_0(.alpha(alpha0),.r(r0),.out(out0));
mux mux_1(.alpha(alpha9),.r(r1),.out(out1));
mux mux_2(.alpha(alpha18),.r(r2),.out(out2));
mux mux_3(.alpha(alpha27),.r(r3),.out(out3));
mux mux_4(.alpha(alpha36),.r(r4),.out(out4));
mux mux_5(.alpha(alpha45),.r(r5),.out(out5));
mux mux_6(.alpha(alpha54),.r(r6),.out(out6));
mux mux_7(.alpha(alpha63),.r(r7),.out(out7));
mux mux_8(.alpha(alpha72),.r(r8),.out(out8));
mux mux_9(.alpha(alpha81),.r(r9),.out(out9));
mux mux_10(.alpha(alpha90),.r(r10),.out(out10));
mux mux_11(.alpha(alpha99),.r(r11),.out(out11));
mux mux_12(.alpha(alpha108),.r(r12),.out(out12));
mux mux_13(.alpha(alpha117),.r(r13),.out(out13));
mux mux_14(.alpha(alpha126),.r(r14),.out(out14));
mux mux_15(.alpha(alpha135),.r(r15),.out(out15));
mux mux_16(.alpha(alpha144),.r(r16),.out(out16));
mux mux_17(.alpha(alpha153),.r(r17),.out(out17));
mux mux_18(.alpha(alpha162),.r(r18),.out(out18));
mux mux_19(.alpha(alpha171),.r(r19),.out(out19));
mux mux_20(.alpha(alpha180),.r(r20),.out(out20));
mux mux_21(.alpha(alpha189),.r(r21),.out(out21));
mux mux_22(.alpha(alpha198),.r(r22),.out(out22));
mux mux_23(.alpha(alpha207),.r(r23),.out(out23));
mux mux_24(.alpha(alpha216),.r(r24),.out(out24));
mux mux_25(.alpha(alpha225),.r(r25),.out(out25));
mux mux_26(.alpha(alpha234),.r(r26),.out(out26));
mux mux_27(.alpha(alpha243),.r(r27),.out(out27));
mux mux_28(.alpha(alpha252),.r(r28),.out(out28));
mux mux_29(.alpha(alpha261),.r(r29),.out(out29));
mux mux_30(.alpha(alpha270),.r(r30),.out(out30));
mux mux_31(.alpha(alpha279),.r(r31),.out(out31));





assign sum=out0^out1^out2^out3^out4^out5^out6^out7^out8^out9^out10
             ^out11^out12^out13^out14^out15^out16^out17^out18^out19^out20
	        ^out21^out22^out23^out24^out25^out26^out27^out28^out29^out30
		   ^out31^feedback;
assign S=d;

multiplier_alpha288 mutilplier(.a(d),.c(feedback));


always@(posedge clk or negedge reset)
begin
           
		 if(!reset)
		 begin
		 d<= #1 13'b0;
		 end
		 else 
		 begin
		 d<= #1 sum;
		 end
		 
		 

end

	   



endmodule
