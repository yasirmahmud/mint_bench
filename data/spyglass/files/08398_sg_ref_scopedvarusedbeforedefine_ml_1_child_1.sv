typedef struct { logic q1;
 logic q2;
 } s1;
 module ScopedVarUsedBeforeDefine_ex1(input ck, input d1);
 s1 ms1;
 always @(posedge ck) begin ms1.q1 <= d1;
 end 
 endmodule
