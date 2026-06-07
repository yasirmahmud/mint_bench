typedef struct { logic q1;
 logic q2;
 } s1;
 module ScopedVarUsedBeforeDefine_ex1(input ck, input d1);
 always @(posedge ck) begin ms1.q1 <= d1;
 end s1 ms1;
 endmodule
