module differ_always_ml_ex1;
reg data;
reg input_a,input_b;
always @* begin data = input_a;
data <= input_b;
end endmodule
