module syndrome_row_11(r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,
                    r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,
				r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31,
                    S,
				clk,
				reset);
//---------------------------S2--------------------------------
wire [12:0]alpha0=13'b0000000000001;
wire [12:0]alpha11=13'b0100000000000;
wire [12:0]alpha22=13'b1011000011011;
wire [12:0]alpha33=13'b0001011110111;
wire [12:0]alpha44=13'b1011111111111;
wire [12:0]alpha55=13'b0011000100100;
wire [12:0]alpha66=13'b1011001000011;
wire [12:0]alpha77=13'b0001100011101;
wire [12:0]alpha88=13'b0001100000001;
wire [12:0]alpha99=13'b0001101000000;
wire [12:0]alpha110=13'b0101011110000;
wire [12:0]alpha121=13'b1100111111111;
wire [12:0]alpha132=13'b0011010111111;
wire [12:0]alpha143=13'b0110101111001;
wire [12:0]alpha154=13'b0001011101001;
wire [12:0]alpha165=13'b0011110111110;
wire [12:0]alpha176=13'b0001110111001;
wire [12:0]alpha187=13'b0000010100010;
wire [12:0]alpha198=13'b1001110111000;
wire [12:0]alpha209=13'b0010010001111;
wire [12:0]alpha220=13'b0000001001101;
wire [12:0]alpha231=13'b0100110011101;
wire [12:0]alpha242=13'b1101111111010;
wire [12:0]alpha253=13'b0001100100100;
wire [12:0]alpha264=13'b0101110000011;
wire [12:0]alpha275=13'b0011000111011;
wire [12:0]alpha286=13'b0111000000010;
wire [12:0]alpha297=13'b1000010011011;
wire [12:0]alpha308=13'b1011100010111;
wire [12:0]alpha319=13'b0010000011010;
wire [12:0]alpha330=13'b0101101011010;
wire [12:0]alpha341=13'b0110010110001;



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
mux mux_1(.alpha(alpha11),.r(r1),.out(out1));
mux mux_2(.alpha(alpha22),.r(r2),.out(out2));
mux mux_3(.alpha(alpha33),.r(r3),.out(out3));
mux mux_4(.alpha(alpha44),.r(r4),.out(out4));
mux mux_5(.alpha(alpha55),.r(r5),.out(out5));
mux mux_6(.alpha(alpha66),.r(r6),.out(out6));
mux mux_7(.alpha(alpha77),.r(r7),.out(out7));
mux mux_8(.alpha(alpha88),.r(r8),.out(out8));
mux mux_9(.alpha(alpha99),.r(r9),.out(out9));
mux mux_10(.alpha(alpha110),.r(r10),.out(out10));
mux mux_11(.alpha(alpha121),.r(r11),.out(out11));
mux mux_12(.alpha(alpha132),.r(r12),.out(out12));
mux mux_13(.alpha(alpha143),.r(r13),.out(out13));
mux mux_14(.alpha(alpha154),.r(r14),.out(out14));
mux mux_15(.alpha(alpha165),.r(r15),.out(out15));
mux mux_16(.alpha(alpha176),.r(r16),.out(out16));
mux mux_17(.alpha(alpha187),.r(r17),.out(out17));
mux mux_18(.alpha(alpha198),.r(r18),.out(out18));
mux mux_19(.alpha(alpha209),.r(r19),.out(out19));
mux mux_20(.alpha(alpha220),.r(r20),.out(out20));
mux mux_21(.alpha(alpha231),.r(r21),.out(out21));
mux mux_22(.alpha(alpha242),.r(r22),.out(out22));
mux mux_23(.alpha(alpha253),.r(r23),.out(out23));
mux mux_24(.alpha(alpha264),.r(r24),.out(out24));
mux mux_25(.alpha(alpha275),.r(r25),.out(out25));
mux mux_26(.alpha(alpha286),.r(r26),.out(out26));
mux mux_27(.alpha(alpha297),.r(r27),.out(out27));
mux mux_28(.alpha(alpha308),.r(r28),.out(out28));
mux mux_29(.alpha(alpha319),.r(r29),.out(out29));
mux mux_30(.alpha(alpha330),.r(r30),.out(out30));
mux mux_31(.alpha(alpha341),.r(r31),.out(out31));




assign sum=out0^out1^out2^out3^out4^out5^out6^out7^out8^out9^out10
             ^out11^out12^out13^out14^out15^out16^out17^out18^out19^out20
	        ^out21^out22^out23^out24^out25^out26^out27^out28^out29^out30
		   ^out31^feedback;
assign S=d;

multiplier_alpha352 mutilplier(.a(d),.c(feedback));


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
