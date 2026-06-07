// cla_adder_6
module cla_adder_6 (
    input [5:0] in1,
    input [5:0] in2,
    input cin,
    output [5:0] sum,
    output cout
);
    wire [6:0] temp_sum;
    assign temp_sum = in1 + in2 + cin;
    assign sum = temp_sum[5:0];
    assign cout = temp_sum[6];
endmodule
