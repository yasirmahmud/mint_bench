module DetectFormalityAborts_ex2(input [7:0] in_data,input [2:0] index_val,output [7:0] out_sum);
reg [7:0] my_array [0:3];
initial begin my_array[0]=8'h10;
my_array[1]=8'h20;
my_array[2]=8'h30;
my_array[3]=8'h40;
end wire [7:0] dont_care_val=my_array[index_val];
wire [7:0] sum=dont_care_val+in_data;
assign out_sum=sum;
endmodule
