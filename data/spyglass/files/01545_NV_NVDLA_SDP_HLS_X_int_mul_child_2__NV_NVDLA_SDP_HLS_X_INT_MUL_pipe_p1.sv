// Dummy module definition for NV_NVDLA_SDP_HLS_X_INT_MUL_pipe_p1
module NV_NVDLA_SDP_HLS_X_INT_MUL_pipe_p1 (
    input                 nvdla_core_clk,
    input                 nvdla_core_rstn,
    input                 bypass_trt,
    input                 mul_final_prdy,
    input  [48:0]         mul_prelu_out,
    input                 mul_sync_pvld,
    output                bypass_trt_reg,
    output [48:0]         mul_data_final,
    output                mul_final_pvld,
    output                mul_sync_prdy
);
    // Original logic: simple wire passthrough for linting purposes
    // assign bypass_trt_reg = bypass_trt;
    // assign mul_data_final = mul_prelu_out;
    // assign mul_final_pvld = mul_sync_pvld;
    // assign mul_sync_prdy  = mul_final_prdy;

    // Fix W240: Change to a registered pipeline stage to utilize nvdla_core_clk and nvdla_core_rstn
    // This change also aligns with the name 'pipe_p1' and the design description of 'pipelining'.
    reg  bypass_trt_reg_r;
    reg  [48:0] mul_data_final_r;
    reg  mul_final_pvld_r;

    // Output assignments from registers
    assign bypass_trt_reg = bypass_trt_reg_r;
    assign mul_data_final = mul_data_final_r;
    assign mul_final_pvld = mul_final_pvld_r;
    // The original logic for mul_sync_prdy was a direct passthrough, this implies
    // a combinational ready path, which is preserved.
    assign mul_sync_prdy  = mul_final_prdy;

    always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
        if (!nvdla_core_rstn) begin
            bypass_trt_reg_r <= 1'b0;
            mul_data_final_r <= 'b0;
            mul_final_pvld_r <= 1'b0;
        end else begin
            // Register inputs to outputs, introducing a single cycle pipeline delay.
            // This models a basic pipeline stage.
            bypass_trt_reg_r <= bypass_trt;
            mul_data_final_r <= mul_prelu_out;
            mul_final_pvld_r <= mul_sync_pvld;
        end
    end
endmodule
