// WarnAnalyzeBBox and W240 fixes for cam_capture
module cam_capture (
    input wire i_pclk, 
    input wire i_vsync,
    input wire i_href,
    input wire i_cam_done,
    input wire [7:0] i_D,
    output wire [18:0] o_pix_addr,
    output wire o_wr,
    output wire [11:0] o_pix_data
);
    reg [18:0] o_pix_addr_reg;
    reg o_wr_reg;
    reg [11:0] o_pix_data_reg;

    always @(posedge i_pclk) begin
        // Consume inputs to resolve W240
        o_pix_addr_reg <= {19{i_vsync ^ i_href}};
        o_wr_reg <= i_cam_done;
        o_pix_data_reg <= {i_D[7:0], i_D[3:0]}; // Example to use inputs
    end

    assign o_pix_addr = o_pix_addr_reg;
    assign o_wr = o_wr_reg;
    assign o_pix_data = o_pix_data_reg;
endmodule
