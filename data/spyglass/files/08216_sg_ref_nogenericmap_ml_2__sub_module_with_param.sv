module sub_module_with_param #(parameter DATA_WIDTH = 8);
 reg [DATA_WIDTH-1:0] data_reg;
 always @(*) begin data_reg = {DATA_WIDTH{1'b0}};
 end endmodule
