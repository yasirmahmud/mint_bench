module UseParamInsteadDefine_ML_ex1(input clk);
 parameter MY_PARAM = 1;

 generate
  if (MY_PARAM) begin : gen_r
   // The 'reg r;' and its 'always' block were removed to resolve W528.
   // Variable 'r' was set but not read, making it unused logic.
   // Removing it preserves the original functional behavior as 'r' had no observable effect.
  end
 endgenerate

endmodule
