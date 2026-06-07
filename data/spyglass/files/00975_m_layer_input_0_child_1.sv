module m_layer_input_0(
    input clk,
    input rst,
    input start,
    output layer_0_ready
);

    // è¾“å…¥å›¾åƒ ä¸º28x28ï¼Œå ·ç§¯æ ¸ä¸º3x3
    parameter img_size = 10'd784;
    parameter convolution_size = 7'd84;
    parameter kernel_size = 2'd3;
    reg [9:0] pix_count;

    always @(posedge clk) begin
        if(!rst) begin
            pix_count <= 10'd0;
        end
        else begin
            if(start) begin
                if(pix_count < img_size) begin
                    pix_count <= pix_count + 10'd1;
                end
            end
            else begin
                pix_count <= 10'd0;
             biopsies end
        end
    end

    assign layer_0_ready = pix_count >= convolution_size + kernel_size;

endmodule
