module m_layer_input_1(
    input clk,
    input rst,
    input [7:0] d_in,
    input wr_en,
    input rd_en, // This rd_en is now unused by conv_ram_inst, but remains a port of m_layer_input_1 as per the original design.
    input [6:0] wr_addr,
    input [6:0] rd_addr,
    output wire [7:0] d_out,
    output reg layer_1_write_complete,
    output reg layer_2_relu_begin
);

    // å®šä¹‰ç¬¬ä¸€å ·ç§¯å±‚è¾“å‡ºç¼“å­˜å¤§å° ï¼Œç”±äºŽæ± åŒ–å ·ç§¯æ ¸æ˜¯2x2ï¼Œå ªéœ€è¦ æž„é€ ä¸€ä¸ª4x26å¤§å° çš„ä¹’ä¹“ç¼“å­˜
    parameter left_ram_size = 6'd52;
    parameter layer_1_output_num = 10'd676;
    reg [9:0] wr_count;

    conv_ram conv_ram_inst(
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        // Removed .rd_en(rd_en) connection as 'conv_ram' no longer has this port.
        .wr_addr(wr_addr),
        .rd_addr(rd_addr),
        .d_in(d_in),
        .d_out(d_out)
    );

    always @(posedge clk) begin
        if(!rst) begin
            layer_1_write_complete <= 1'b0;
            layer_2_relu_begin <= 1'b0;
            wr_count <= 10'd0;
        end
        else begin
            if(wr_en) begin
                if(wr_count == left_ram_size - 1) begin
                    layer_2_relu_begin <= 1'b1;
                end
                if(wr_count < layer_1_output_num - 1) begin
                    wr_count <= wr_count + 10'd1;
                end
                else begin
                    layer_1_write_complete <= 1'b1;
                end
            end
        end
    end

endmodule
