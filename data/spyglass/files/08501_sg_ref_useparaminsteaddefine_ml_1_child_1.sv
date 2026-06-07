module UseParamInsteadDefine_ML_ex1(input clk);
 parameter MY_PARAM = 1;

 generate
  if (MY_PARAM) begin : gen_r
   reg r;
   always @(posedge clk) r <= 1'b0;
  end
 endgenerate

endmodule
