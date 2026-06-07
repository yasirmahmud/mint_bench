module syndrome_row_14(r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,
                    r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,
				r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31,
                    S,
				clk,reset);
//---------------------------S2--------------------------------
wire [12:0]alpha0=13'b0000000000001;
wire [12:0]alpha14=13'b0000000110110;
wire [12:0]alpha28=13'b0010100010100;
wire [12:0]alpha42=13'b0110111111001;
wire [12:0]alpha56=13'b0110001001000;
wire [12:0]alpha70=13'b0010011000101;
wire [12:0]alpha84=13'b0111000110100;
wire [12:0]alpha98=13'b0000110100000;
wire [12:0]alpha112=13'b0101111011011;
wire [12:0]alpha126=13'b1111010010011;
wire [12:0]alpha140=13'b1110110100111;
wire [12:0]alpha154=13'b0001011101001;
wire [12:0]alpha168=13'b1110111101011;
wire [12:0]alpha182=13'b0111000000001;
wire [12:0]alpha196=13'b0010011101110;
wire [12:0]alpha210=13'b0100100011110;
wire [12:0]alpha224=13'b0010011010000;
wire [12:0]alpha238=13'b0110110111010;
wire [12:0]alpha252=13'b0000110010010;
wire [12:0]alpha266=13'b0111000010111;
wire [12:0]alpha280=13'b0011100111010;
wire [12:0]alpha294=13'b0011000010000;
wire [12:0]alpha308=13'b1011100010111;
wire [12:0]alpha322=13'b0000011001011;
wire [12:0]alpha336=13'b1011101101010;
wire [12:0]alpha350=13'b0100110110101;
wire [12:0]alpha364=13'b1100011111010;
wire [12:0]alpha378=13'b0001100010110;
wire [12:0]alpha392=13'b1100111100010;
wire [12:0]alpha406=13'b1011111011101;
wire [12:0]alpha420=13'b1011110010111;
wire [12:0]alpha434=13'b1101111001011;


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
mux mux_1(.alpha(alpha14),.r(r1),.out(out1));
mux mux_2(.alpha(alpha28),.r(r2),.out(out2));
mux mux_3(.alpha(alpha42),.r(r3),.out(out3));
mux mux_4(.alpha(alpha56),.r(r4),.out(out4));
mux mux_5(.alpha(alpha70),.r(r5),.out(out5));
mux mux_6(.alpha(alpha84),.r(r6),.out(out6));
mux mux_7(.alpha(alpha98),.r(r7),.out(out7));
mux mux_8(.alpha(alpha112),.r(r8),.out(out8));
mux mux_9(.alpha(alpha126),.r(r9),.out(out9));
mux mux_10(.alpha(alpha140),.r(r10),.out(out10));
mux mux_11(.alpha(alpha154),.r(r11),.out(out11));
mux mux_12(.alpha(alpha168),.r(r12),.out(out12));
mux mux_13(.alpha(alpha182),.r(r13),.out(out13));
mux mux_14(.alpha(alpha196),.r(r14),.out(out14));
mux mux_15(.alpha(alpha210),.r(r15),.out(out15));
mux mux_16(.alpha(alpha224),.r(r16),.out(out16));
mux mux_17(.alpha(alpha238),.r(r17),.out(out17));
mux mux_18(.alpha(alpha252),.r(r18),.out(out18));
mux mux_19(.alpha(alpha266),.r(r19),.out(out19));
mux mux_20(.alpha(alpha280),.r(r20),.out(out20));
mux mux_21(.alpha(alpha294),.r(r21),.out(out21));
mux mux_22(.alpha(alpha308),.r(r22),.out(out22));
mux mux_23(.alpha(alpha322),.r(r23),.out(out23));
mux mux_24(.alpha(alpha336),.r(r24),.out(out24));
mux mux_25(.alpha(alpha350),.r(r25),.out(out25));
mux mux_26(.alpha(alpha364),.r(r26),.out(out26));
mux mux_27(.alpha(alpha378),.r(r27),.out(out27));
mux mux_28(.alpha(alpha392),.r(r28),.out(out28));
mux mux_29(.alpha(alpha406),.r(r29),.out(out29));
mux mux_30(.alpha(alpha420),.r(r30),.out(out30));
mux mux_31(.alpha(alpha434),.r(r31),.out(out31));




assign sum=out0^out1^out2^out3^out4^out5^out6^out7^out8^out9^out10
             ^out11^out12^out13^out14^out15^out16^out17^out18^out19^out20
	        ^out21^out22^out23^out24^out25^out26^out27^out28^out29^out30
		   ^out31^feedback;
assign S=d;

multiplier_alpha448 mutilplier(.a(d),.c(feedback));


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
