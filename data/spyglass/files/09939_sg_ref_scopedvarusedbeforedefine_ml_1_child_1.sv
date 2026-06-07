typedef struct { logic q1;
 logic q2;
 } s1;
 module ScopedVarUsedBeforeDefine_ex1(input ck, input d1);
 s1 ms1; // Declaration moved before usage to resolve ScopedVarUsedBeforeDefine-ML
 logic _sg_unused_ms1_q1; // Added to resolve W528: Variable 'ms1.q1' set but not read.
 always @(posedge ck) begin
   ms1.q1 <= d1;
   _sg_unused_ms1_q1 <= ms1.q1; // Reading ms1.q1 to resolve W528
 end
 endmodule
