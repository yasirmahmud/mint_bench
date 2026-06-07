module syndrome_row_6(r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,
                    r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,
				r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31,
                    S,
				clk,
				reset);
//---------------------------S2--------------------------------
wire [12:0]alpha0=13'b0000000000001;
wire [12:0]alpha6=13'b0000001000000;
wire [12:0]alpha12=13'b1000000000000;
wire [12:0]alpha18=13'b0001101100000;
wire [12:0]alpha24=13'b1100001011010;
wire [12:0]alpha30=13'b1010001010000;
wire [12:0]alpha36=13'b1011110111000;
wire [12:0]alpha42=13'b0110111111001;
wire [12:0]alpha48=13'b1111100000101;
wire [12:0]alpha54=13'b0001100010010;
wire [12:0]alpha60=13'b0010011011010;
wire [12:0]alpha66=13'b1011001000011;
wire [12:0]alpha72=13'b1001100010100;
wire [12:0]alpha78=13'b0011000111010;
wire [12:0]alpha84=13'b0111000110100;
wire [12:0]alpha90=13'b0110000000100;
wire [12:0]alpha96=13'b0000001101000;
wire [12:0]alpha102=13'b1101000000000;
wire [12:0]alpha108=13'b0001010111100;
wire [12:0]alpha114=13'b0111101110111;
wire [12:0]alpha120=13'b1110011110010;
wire [12:0]alpha126=13'b1111010010011;
wire [12:0]alpha132=13'b0011010111111;
wire [12:0]alpha138=13'b0111101101111;
wire [12:0]alpha144=13'b1101011110010;
wire [12:0]alpha150=13'b1111000100111;
wire [12:0]alpha156=13'b0101110100100;
wire [12:0]alpha162=13'b0100011110001;
wire [12:0]alpha168=13'b1110111101011;
wire [12:0]alpha174=13'b1100011100101;
wire [12:0]alpha180=13'b1101110001011;
wire [12:0]alpha186=13'b0000001010001;



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
mux mux_1(.alpha(alpha6),.r(r1),.out(out1));
mux mux_2(.alpha(alpha12),.r(r2),.out(out2));
mux mux_3(.alpha(alpha18),.r(r3),.out(out3));
mux mux_4(.alpha(alpha24),.r(r4),.out(out4));
mux mux_5(.alpha(alpha30),.r(r5),.out(out5));
mux mux_6(.alpha(alpha36),.r(r6),.out(out6));
mux mux_7(.alpha(alpha42),.r(r7),.out(out7));
mux mux_8(.alpha(alpha48),.r(r8),.out(out8));
mux mux_9(.alpha(alpha54),.r(r9),.out(out9));
mux mux_10(.alpha(alpha60),.r(r10),.out(out10));
mux mux_11(.alpha(alpha66),.r(r11),.out(out11));
mux mux_12(.alpha(alpha72),.r(r12),.out(out12));
mux mux_13(.alpha(alpha78),.r(r13),.out(out13));
mux mux_14(.alpha(alpha84),.r(r14),.out(out14));
mux mux_15(.alpha(alpha90),.r(r15),.out(out15));
mux mux_16(.alpha(alpha96),.r(r16),.out(out16));
mux mux_17(.alpha(alpha102),.r(r17),.out(out17));
mux mux_18(.alpha(alpha108),.r(r18),.out(out18));
mux mux_19(.alpha(alpha114),.r(r19),.out(out19));
mux mux_20(.alpha(alpha120),.r(r20),.out(out20));
mux mux_21(.alpha(alpha126),.r(r21),.out(out21));
mux mux_22(.alpha(alpha132),.r(r22),.out(out22));
mux mux_23(.alpha(alpha138),.r(r23),.out(out23));
mux mux_24(.alpha(alpha144),.r(r24),.out(out24));
mux mux_25(.alpha(alpha150),.r(r25),.out(out25));
mux mux_26(.alpha(alpha156),.r(r26),.out(out26));
mux mux_27(.alpha(alpha162),.r(r27),.out(out27));
mux mux_28(.alpha(alpha168),.r(r28),.out(out28));
mux mux_29(.alpha(alpha174),.r(r29),.out(out29));
mux mux_30(.alpha(alpha180),.r(r30),.out(out30));
mux mux_31(.alpha(alpha186),.r(r31),.out(out31));





assign sum=out0^out1^out2^out3^out4^out5^out6^out7^out8^out9^out10
             ^out11^out12^out13^out14^out15^out16^out17^out18^out19^out20
	        ^out21^out22^out23^out24^out25^out26^out27^out28^out29^out30
		   ^out31^feedback;
assign S=d;

multiplier_alpha192 mutilplier(.a(d),.c(feedback));


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
