module SequentialMultiplier  (
    input [31:0] A,
    input [31:0] B,
    output [63:0] Product
);


wire [31:0] Ain;
wire [31:0] Bin;
wire [31:0] acum;
wire [63:0] ShiftAdd [32:0];
wire [31:0] sums [31:0];
wire [31:0] carries;
assign Ain = (A[31] == 1) ? (~A + 1) : A;

assign Bin = (B[31] == 1) ? (~B + 1): B;

assign ShiftAdd[0][63:32] = 32'b0;
assign ShiftAdd[0][31:0] = Bin;

genvar i;
reg M;
generate
    for(i=1; i< 33; i=i+1)  begin
        CarryBypassAdder ShiftAddbits_(Ain, ShiftAdd[i-1][63:32], 1'b0, sums[i-1],carries[i-1],acum[i-1]);
        assign ShiftAdd[i][63:32] = (ShiftAdd[i-1][0]==0) ? {1'b0,ShiftAdd[i-1][63:33]} : {carries[i-1],sums[i-1][31:1]};
        assign ShiftAdd[i][31:0] = (ShiftAdd[i-1][0]==0) ? ShiftAdd[i-1][32:1]: {sums[i-1][0],ShiftAdd[i-1][31:1]};
    end
endgenerate

assign Product = ((A[31] == 1)^(B[31] == 1))?(~ShiftAdd[32] + 1) : ShiftAdd[32] ;

endmodule
