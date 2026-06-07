module sub_module_with_param #(parameter DATA_WIDTH = 8) (
    output [DATA_WIDTH-1:0] data_reg_out // Output port added to resolve W528 on data_reg
);
 reg [DATA_WIDTH-1:0] data_reg;

 always @(*) begin
   data_reg = {DATA_WIDTH{1'b0}};
 end

 assign data_reg_out = data_reg; // 'data_reg' is now read by driving the output port

endmodule
