module UseParamInsteadDefine_ML_ex1(input clk);
 parameter MY_PARAM = 1;
 `define MY_PARAM `ifdef MY_PARAM reg r;
 always @(posedge clk) r <= 1'b0;
 `endif endmodule
