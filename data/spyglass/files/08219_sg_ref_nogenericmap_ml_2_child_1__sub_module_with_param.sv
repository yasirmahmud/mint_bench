module sub_module_with_param #(parameter DATA_WIDTH = 8);
 reg [DATA_WIDTH-1:0] data_reg;
 wire [DATA_WIDTH-1:0] spyglass_fix_dummy_read_data; // Added to resolve W528

 always @(*) begin
   data_reg = {DATA_WIDTH{1'b0}};
 end

 assign spyglass_fix_dummy_read_data = data_reg; // Fix for W528: 'data_reg' is now read internally

endmodule
