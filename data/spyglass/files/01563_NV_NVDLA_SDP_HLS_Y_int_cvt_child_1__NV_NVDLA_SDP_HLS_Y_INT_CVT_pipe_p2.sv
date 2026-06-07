// NV_NVDLA_SDP_HLS_Y_INT_CVT_pipe_p2 definition
module NV_NVDLA_SDP_HLS_Y_INT_CVT_pipe_p2 #(
    parameter DATA_WIDTH = 49
) (
   input         nvdla_core_clk
  ,input         nvdla_core_rstn
  ,input  [DATA_WIDTH-1:0] mul_dout
  ,input         sub_out_pvld // Valid from previous stage (input valid for this pipe)
  ,input         mul_out_prdy // Ready from next stage (output ready for this pipe)
  ,output reg [DATA_WIDTH-1:0] mul_data_out
  ,output reg         mul_out_pvld // Valid for next stage (output valid for this pipe)
  ,output wire         sub_out_prdy // Ready for previous stage (input ready for this pipe)
);

reg mul_data_valid; // Internal register to hold validity

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        mul_data_out <= {DATA_WIDTH{1'b0}};
        mul_data_valid <= 1'b0;
    end else begin
        if (sub_out_pvld && sub_out_prdy) begin // Capture input when valid_in and ready_in are high
            mul_data_out <= mul_dout;
            mul_data_valid <= 1'b1;
        }
        // Only consume data if it's valid and the next stage is ready
        else if (mul_data_valid && mul_out_prdy) begin 
            mul_data_valid <= 1'b0;
        end
    end
end

assign sub_out_prdy = mul_out_prdy || !mul_data_valid; // We are ready if downstream is ready OR we are empty
assign mul_out_pvld = mul_data_valid; // Our output is valid if we hold valid data

endmodule
