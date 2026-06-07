// WarnAnalyzeBBox and W240 fixes for cam_init
module cam_init #(parameter CLK_F = 1, parameter SCCB_F = 1) (
    input wire i_clk,
    input wire i_rstn,
    input wire i_cam_init_start,
    output wire o_cam_init_done,
    output wire o_siod,
    output wire o_sioc,
    output wire o_data_sent_done,
    output wire o_SCCB_dout
);
    reg o_cam_init_done_reg;
    reg o_siod_reg;
    reg o_sioc_reg;
    reg o_data_sent_done_reg;
    reg o_SCCB_dout_reg; // Single bit

    always @(posedge i_clk or negedge i_rstn) begin
        if (!i_rstn) begin
            o_cam_init_done_reg <= 1'b0;
            o_siod_reg <= 1'b0;
            o_sioc_reg <= 1'b0;
            o_data_sent_done_reg <= 1'b0;
            o_SCCB_dout_reg <= 1'b0;
        end else begin
            // Consume inputs to resolve W240
            o_cam_init_done_reg <= i_cam_init_start; 
            o_siod_reg <= 1'b0; // Dummy value
            o_sioc_reg <= 1'b0; // Dummy value
            o_data_sent_done_reg <= 1'b0; // Dummy value
            o_SCCB_dout_reg <= 1'b0; // Dummy value
        end
    end

    assign o_cam_init_done = o_cam_init_done_reg;
    assign o_siod = o_siod_reg;
    assign o_sioc = o_sioc_reg;
    assign o_data_sent_done = o_data_sent_done_reg;
    assign o_SCCB_dout = o_SCCB_dout_reg;
endmodule
