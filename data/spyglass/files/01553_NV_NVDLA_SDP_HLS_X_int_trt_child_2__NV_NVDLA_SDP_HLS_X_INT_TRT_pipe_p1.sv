// Definition for NV_NVDLA_SDP_HLS_X_INT_TRT_pipe_p1
module NV_NVDLA_SDP_HLS_X_INT_TRT_pipe_p1 (
    input                        nvdla_core_clk,
    input                        nvdla_core_rstn,
    input                        mul_out_pvld, // input valid
    input  [31:0]                trt_dout,     // input data
    input                        trt_out_prdy, // output ready
    output                       mul_out_prdy, // input ready
    output [31:0]                trt_data_out, // output data
    output                       trt_out_pvld  // output valid
);

reg  [31:0]  data_reg;
reg          valid_reg;

// Combinational wires for pipeline control
wire   can_accept_new_data = mul_out_pvld && mul_out_prdy;
wire   can_output_data     = valid_reg    && trt_out_prdy;

// input ready: ready to accept new data if stage is empty OR
//              if stage is full but data is being consumed
assign mul_out_prdy = !valid_reg || trt_out_prdy;

// output valid: valid data is available if 'valid_reg' is set
assign trt_out_pvld = valid_reg;

// output data is the registered data
assign trt_data_out = data_reg;

always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        data_reg  <= 'b0;
        valid_reg <= 1'b0;
    end else begin
        if (can_output_data) begin // Data is consumed from the pipeline stage
            if (can_accept_new_data) begin // New data also arrives
                data_reg  <= trt_dout;
                valid_reg <= 1'b1; // Stage remains valid with new data
            end else begin // No new data arrives, stage becomes empty
                valid_reg <= 1'b0;
            end
        end else if (can_accept_new_data) begin // New data arrives, but old data is not consumed
            data_reg  <= trt_dout;
            valid_reg <= 1'b1; // Stage becomes valid
        end
        // Else: No data consumed, no new data arrives (stall condition), state remains unchanged.
    end
end

endmodule
