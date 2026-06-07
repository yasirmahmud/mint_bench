module cla32  (
    input wire [31:0] A,
    input wire [31:0] B,
    input wire Cin,
    output wire [31:0] S,
    output wire Cout
    );

    wire [7:0] GG,PG,Ct;
	CLA_4  A1(A[3:0], B[3:0], Cin, S[3:0], Ct[0], PG[0], GG[0]);
	CLA_4 A2(A[7:4], B[7:4], Ct[0], S[7:4], Ct[1], PG[1], GG[1]);
	CLA_4 A3(A[11:8], B[11:8], Ct[1], S[11:8], Ct[2], PG[2], GG[2]);
	CLA_4 A4(A[15:12], B[15:12], Ct[2], S[15:12], Ct[3], PG[3], GG[3]);
	CLA_4 A5(A[19:16], B[19:16], Ct[3], S[19:16], Ct[4], PG[4], GG[4]);
	CLA_4 A6(A[23:20], B[23:20], Ct[4], S[23:20], Ct[5], PG[5], GG[5]);
	CLA_4 A7(A[27:24], B[27:24], Ct[5], S[27:24], Ct[6], PG[6], GG[6]);
	CLA_4 A8(A[31:28], B[31:28], Ct[6], S[31:28], Ct[7], PG[7], GG[7]);
	
	assign Cout=Ct[7];
endmodule
