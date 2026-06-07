module syndrome_row_7(r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,
                    r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,
			r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31,
                    S,
			clk,reset);
//---------------------------S2--------------------------------
wire [12:0]alpha0=13'b0000000000001;
wire [12:0]alpha7=13'b0000010000000;
wire [12:0]alpha14=13'b0000000110110;
wire [12:0]alpha21=13'b1101100000000;
wire [12:0]alpha28=13'b0010100010100;
wire [12:0]alpha35=13'b0101111011100;
wire [12:0]alpha42=13'b0110111111001;
wire [12:0]alpha49=13'b1111000010001;
wire [12:0]alpha56=13'b0110001001000;
wire [12:0]alpha63=13'b0011011001011;
wire [12:0]alpha70=13'b0010011000101;
wire [12:0]alpha77=13'b0001100011101;
wire [12:0]alpha84=13'b0111000110100;
wire [12:0]alpha91=13'b1100000001000;
wire [12:0]alpha98=13'b0000110100000;
wire [12:0]alpha105=13'b1000001011010;
wire [12:0]alpha112=13'b0101111011011;
wire [12:0]alpha119=13'b0111001111001;
wire [12:0]alpha126=13'b1111010010011;
wire [12:0]alpha133=13'b0110101111110;
wire [12:0]alpha140=13'b1110110100111;
wire [12:0]alpha147=13'b1011111001010;
wire [12:0]alpha154=13'b0001011101001;
wire [12:0]alpha161=13'b1010001110101;
wire [12:0]alpha168=13'b1110111101011;
wire [12:0]alpha175=13'b1000111010001;
wire [12:0]alpha182=13'b0111000000001;
wire [12:0]alpha189=13'b0001010001000;
wire [12:0]alpha196=13'b0010011101110;
wire [12:0]alpha203=13'b1011010011101;
wire [12:0]alpha210=13'b0100100011110;
wire [12:0]alpha217=13'b0110000001100;


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

reg [12:0]d; // Removed initial assignment to fix SYNTH_89
	


mux mux_0(.alpha(alpha0),.r(r0),.out(out0));
mux mux_1(.alpha(alpha7),.r(r1),.out(out1));
mux mux_2(.alpha(alpha14),.r(r2),.out(out2));
mux mux_3(.alpha(alpha21),.r(r3),.out(out3));
mux mux_4(.alpha(alpha28),.r(r4),.out(out4));
mux mux_5(.alpha(alpha35),.r(r5),.out(out5));
mux mux_6(.alpha(alpha42),.r(r6),.out(out6));
mux mux_7(.alpha(alpha49),.r(r7),.out(out7));
mux mux_8(.alpha(alpha56),.r(r8),.out(out8));
mux mux_9(.alpha(alpha63),.r(r9),.out(out9));
mux mux_10(.alpha(alpha70),.r(r10),.out(out10));
mux mux_11(.alpha(alpha77),.r(r11),.out(out11));
mux mux_12(.alpha(alpha84),.r(r12),.out(out12));
mux mux_13(.alpha(alpha91),.r(r13),.out(out13));
mux mux_14(.alpha(alpha98),.r(r14),.out(out14));
mux mux_15(.alpha(alpha105),.r(r15),.out(out15));
mux mux_16(.alpha(alpha112),.r(r16),.out(out16));
mux mux_17(.alpha(alpha119),.r(r17),.out(out17));
mux mux_18(.alpha(alpha126),.r(r18),.out(out18));
mux mux_19(.alpha(alpha133),.r(r19),.out(out19));
mux mux_20(.alpha(alpha140),.r(r20),.out(out20));
mux mux_21(.alpha(alpha147),.r(r21),.out(out21));
mux mux_22(.alpha(alpha154),.r(r22),.out(out22));
mux mux_23(.alpha(alpha161),.r(r23),.out(out23));
mux mux_24(.alpha(alpha168),.r(r24),.out(out24));
mux mux_25(.alpha(alpha175),.r(r25),.out(out25));
mux mux_26(.alpha(alpha182),.r(r26),.out(out26));
mux mux_27(.alpha(alpha189),.r(r27),.out(out27));
mux mux_28(.alpha(alpha196),.r(r28),.out(out28));
mux mux_29(.alpha(alpha203),.r(r29),.out(out29));
mux mux_30(.alpha(alpha210),.r(r30),.out(out30));
mux mux_31(.alpha(alpha217),.r(r31),.out(out31));





assign sum=out0^out1^out2^out3^out4^out5^out6^out7^out8^out9^out10
             ^out11^out12^out13^out14^out15^out16^out17^out18^out19^out20
	        ^out21^out22^out23^out24^out25^out26^out27^out28^out29^out30
		   ^out31^feedback;
assign S=d;

multiplier_alpha224 mutilplier(.a(d),.c(feedback));

always@(posedge clk or negedge reset)
begin
           
		 if(!reset)
		 begin
		 d<= 13'b0; // Removed #1 delay to fix CheckDelayTimescale-ML
		 end
		 else 
		 begin
		 d<= sum;
		 end
		 
		

end

	   


endmodule
