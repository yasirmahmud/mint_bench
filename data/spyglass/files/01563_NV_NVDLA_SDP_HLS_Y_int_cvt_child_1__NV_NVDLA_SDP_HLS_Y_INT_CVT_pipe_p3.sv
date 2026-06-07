// NV_NVDLA_SDP_HLS_Y_INT_CVT_pipe_p3 definition
module NV_NVDLA_SDP_HLS_Y_INT_CVT_pipe_p3 #(
    parameter DATA_WIDTH = 32
) (
   input         nvdla_core_clk
  ,input         nvdla_core_rstn
  ,input  [DATA_WIDTH-1:0] cvt_dout
  ,input         final_out_pvld // Valid from previous stage (input valid for this pipe)
  ,input         cvt_out_prdy   // Ready from next stage (output ready for this pipe)
  ,output reg [DATA_WIDTH-1:0] cvt_data_out
  ,output reg         cvt_out_pvld   // Valid for next stage (output valid for this pipe)
  ,output wire         final_out_prdy // Ready for previous stage (input ready for this pipe)
);

reg cvt_data_valid; // Internal register to hold validity

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        cvt_data_out <= {DATA_WIDTH{1'b0}};
        cvt_data_valid <= 1'b0;
    end else begin
        if (final_out_pvld && final_out_prdy) begin // Capture input when valid_in and ready_in are high
            cvt_data_out <= cvt_dout;
            cvt_data_valid <= 1'b1;
        } 
        // Only consume data if it's valid and the next stage is ready
        else if (cvt_data_valid && cvt_out_prdy) begin
            cvt_data_valid <= 1'b0;
        end
    end
end

assign final_out_prdy = cvt_out_prdy || !cvt_data_valid; // We are ready if downstream is ready OR we are empty
assign cvt_out_pvld = cvt_data_valid; // Our output is valid if we hold valid data

endmodule
