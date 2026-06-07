module RepeatedLogic_ML_ex1;
reg [7:0] data_in;
reg [7:0] result;
integer i;
parameter P1 = 8;
parameter P2 = 4;
always @(*) begin result = 0;
for (i = 0; i < 10; i = i + 1) begin result = result + (P1 + P2);
end end endmodule
