// NV_NVDLA_SDP_HLS_Y_INT_CVT_pipe_p1 definition
module NV_NVDLA_SDP_HLS_Y_INT_CVT_pipe_p1 #(
    parameter DATA_WIDTH = 33
) (
   input         nvdla_core_clk
  ,input         nvdla_core_rstn
  ,input  [DATA_WIDTH-1:0] sub_dout
  ,input         sub_in_pvld
  ,input         sub_out_prdy // Ready from next stage
  ,output reg [DATA_WIDTH-1:0] sub_data_out
  ,output wire         sub_in_prdy  // Ready for previous stage
  ,output reg         sub_out_pvld // Valid for next stage
);

reg sub_data_valid; // Internal register to hold validity

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        sub_data_out <= {DATA_WIDTH{1'b0}};
        sub_data_valid <= 1'b0;
    end else begin
        if (sub_in_pvld && sub_in_prdy) begin // Capture input when valid_in and ready_in are high
            sub_data_out <= sub_dout;
            sub_data_valid <= 1'b1;
        end else if (sub_data_valid && sub_out_prdy) begin // Release output when valid_out and ready_out are high
            sub_data_valid <= 1'b0;
        end
    end
end

assign sub_in_prdy  = sub_out_prdy || !sub_data_valid; // We are ready if downstream is ready OR we are empty
assign sub_out_pvld = sub_data_valid; // Our output is valid if we hold valid data

endmodule
