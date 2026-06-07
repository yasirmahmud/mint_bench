module memberwidthmismatch_ml_ex2;
 localparam [4:0] A = 5'd10;
 localparam [2:0] B = 3'd2;
 localparam [2:0] C = 3'd1;
 localparam [2:0] D = 3'd3;

 output result;
 assign result = (A + B) == ({ {2{1'b0}}, C } + { {2{1'b0}}, D });

endmodule
