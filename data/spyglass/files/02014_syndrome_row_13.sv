module syndrome_row_13(r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,
                    r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,
				r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31,
                    S,
				clk,
				reset);
//---------------------------S2--------------------------------
wire [12:0]alpha0=13'b0000000000001;
wire [12:0]alpha13=13'b0000000011011;
wire [12:0]alpha26=13'b0000101000101;
wire [12:0]alpha39=13'b1110110110111;
wire [12:0]alpha52=13'b1000011001001;
wire [12:0]alpha65=13'b1101100101100;
wire [12:0]alpha78=13'b0011000111010;
wire [12:0]alpha91=13'b1100000001000;
wire [12:0]alpha104=13'b0100000101101;
wire [12:0]alpha117=13'b1101110010101;
wire [12:0]alpha130=13'b0100110101001;
wire [12:0]alpha143=13'b0110101111001;
wire [12:0]alpha156=13'b0101110100100;
wire [12:0]alpha169=13'b1101111001101;
wire [12:0]alpha182=13'b0111000000001;
wire [12:0]alpha195=13'b0001001110111;
wire [12:0]alpha208=13'b1001001001010;
wire [12:0]alpha221=13'b0000010011010;
wire [12:0]alpha234=13'b0110011011110;
wire [12:0]alpha247=13'b1111000000101;
wire [12:0]alpha260=13'b1001010110100;
wire [12:0]alpha273=13'b0100110001000;
wire [12:0]alpha286=13'b0111000000010;
wire [12:0]alpha299=13'b0001001011010;
wire [12:0]alpha312=13'b1000110000101;
wire [12:0]alpha325=13'b0011001011000;
wire [12:0]alpha338=13'b1110110011110;
wire [12:0]alpha351=13'b1001101101010;
wire [12:0]alpha364=13'b1100011111010;
wire [12:0]alpha377=13'b0000110001011;
wire [12:0]alpha390=13'b1011001110101;
wire [12:0]alpha403=13'b0111011111110;



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
mux mux_1(.alpha(alpha13),.r(r1),.out(out1));
mux mux_2(.alpha(alpha26),.r(r2),.out(out2));
mux mux_3(.alpha(alpha39),.r(r3),.out(out3));
mux mux_4(.alpha(alpha52),.r(r4),.out(out4));
mux mux_5(.alpha(alpha65),.r(r5),.out(out5));
mux mux_6(.alpha(alpha78),.r(r6),.out(out6));
mux mux_7(.alpha(alpha91),.r(r7),.out(out7));
mux mux_8(.alpha(alpha104),.r(r8),.out(out8));
mux mux_9(.alpha(alpha117),.r(r9),.out(out9));
mux mux_10(.alpha(alpha130),.r(r10),.out(out10));
mux mux_11(.alpha(alpha143),.r(r11),.out(out11));
mux mux_12(.alpha(alpha156),.r(r12),.out(out12));
mux mux_13(.alpha(alpha169),.r(r13),.out(out13));
mux mux_14(.alpha(alpha182),.r(r14),.out(out14));
mux mux_15(.alpha(alpha195),.r(r15),.out(out15));
mux mux_16(.alpha(alpha208),.r(r16),.out(out16));
mux mux_17(.alpha(alpha221),.r(r17),.out(out17));
mux mux_18(.alpha(alpha234),.r(r18),.out(out18));
mux mux_19(.alpha(alpha247),.r(r19),.out(out19));
mux mux_20(.alpha(alpha260),.r(r20),.out(out20));
mux mux_21(.alpha(alpha273),.r(r21),.out(out21));
mux mux_22(.alpha(alpha286),.r(r22),.out(out22));
mux mux_23(.alpha(alpha299),.r(r23),.out(out23));
mux mux_24(.alpha(alpha312),.r(r24),.out(out24));
mux mux_25(.alpha(alpha325),.r(r25),.out(out25));
mux mux_26(.alpha(alpha338),.r(r26),.out(out26));
mux mux_27(.alpha(alpha351),.r(r27),.out(out27));
mux mux_28(.alpha(alpha364),.r(r28),.out(out28));
mux mux_29(.alpha(alpha377),.r(r29),.out(out29));
mux mux_30(.alpha(alpha390),.r(r30),.out(out30));
mux mux_31(.alpha(alpha403),.r(r31),.out(out31));




assign sum=out0^out1^out2^out3^out4^out5^out6^out7^out8^out9^out10
             ^out11^out12^out13^out14^out15^out16^out17^out18^out19^out20
	        ^out21^out22^out23^out24^out25^out26^out27^out28^out29^out30
		   ^out31^feedback;
assign S=d;

multiplier_alpha416 mutilplier(.a(d),.c(feedback));


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
