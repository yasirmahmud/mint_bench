module m_max_relu_2(
    input clk,
    input rst,
    input layer_2_relu_begin,
    input [7:0] d_in,
    output reg rd_en = 1'b0,
    output reg [6:0] ram_read_addr = 10'd0,
    output reg [7:0] d_out,
    output reg data_available = 1'b0,
    output layer_2_ready
);

    // å½ç¬¬ä¸å±å·ç§¯å±åå®åï¼è®¾ç½®è¯»ä½¿è½
    always @(posedge clk) begin
        if(!rst) begin
            rd_en <= 1'b0;
        end
        else begin
            if(layer_2_relu_begin) begin
                if(!layer_2_ready) begin
                    rd_en <= 1'b1;
                end
                else begin
                    rd_en <= 1'b0;
                end
            end
            else begin
                rd_en <= 1'b0;
            end
        end
    end

    // è®¾ç½®è¯»å°åä»¥åè®¡ç®æå¤§æ± å
    parameter pool_stride = 2'd2;
    parameter  input_raw = 6'd26;
    parameter 
        POOL_ONE = 3'd0,
        POOL_TWO = 3'd1,
        POOL_THREE = 3'd2,
        POOL_FOUR = 3'd3;
    // æ± åå·ç§¯æ ¸å¤§å°
    parameter pool_size = 3'd4;
    reg [2:0] pool_count = POOL_TWO;
    // æ± ååºåçé¦å°å
    reg [6:0] head_addr = 7'd0;
    parameter input_raw_div = 4'd13;
    // æ± ååºåé¦å°åå¨ä¸è¡ä¸­çæ¹åæ¬¡æ°
    reg [3:0] head_addr_jump_count = 4'd0;
    parameter input_line_div = 4'd13;
    // æ± ååºåé¦å°åæ¹åçè¡æ°
    reg [3:0] line_count = 4'd0;
    always @(posedge clk) begin
        if(!rst) begin
            ram_read_addr <= 7'd0;
            d_out <= 8'd0;
            pool_count <= POOL_TWO;
            head_addr <= 7'd0;
            head_addr_jump_count <= 4'd0;
            data_available <= 1'b0;
            line_count <= 4'd0;
        end
        else begin
            if(rd_en) begin
                pool_count <= pool_count < pool_size - 1? pool_count + 3'd1:POOL_ONE;
                // æ ¹æ®æ± åå·ç§¯æ ¸å¤§å°åè¾å¥å¾åæ¥è®¡ç®è¯»ramå°å
                case(pool_count)
                    POOL_ONE: begin
                        ram_read_addr <= head_addr;
                        if(d_in > d_out) begin
                            d_out <= d_in;
                        end
                        data_available <= 1'b1;
                    end
                    POOL_TWO: begin
                        ram_read_addr <= head_addr + 7'd1;
                        d_out <= d_in;
                        data_available <= 1'b0;
                    end
                    POOL_THREE: begin
                        ram_read_addr <= head_addr + 7'd1 + input_raw;
                        if(d_in > d_out) begin
                            d_out <= d_in;
                        end
                    end
                    POOL_FOUR: begin
                        ram_read_addr <= head_addr + input_raw;
                        head_addr_jump_count <= head_addr_jump_count < input_raw_div - 1? head_addr_jump_count + 4'd1:4'd0;
                        if(head_addr_jump_count < input_raw_div - 1) begin
                            head_addr <= head_addr + pool_stride;
                        end
                        else begin
                            head_addr <= head_addr == input_raw - pool_stride? input_raw << 1:0;
                            if(line_count < input_line_div) begin
                                line_count <= line_count + 4'd1;
                            end
                        end
                        if(d_in > d_out) begin
                            d_out <= d_in;
                        end
                    end
                    default: begin
                        ram_read_addr <= head_addr;
                    end
                endcase
            end
            else begin
                ram_read_addr <= 10'd0;
                d_out <= 8'd0;
                pool_count <= POOL_TWO;
                head_addr <= 10'd0;
                head_addr_jump_count <= 4'd0;
                data_available <= 1'b0;
            end
        end
    end

    // å¤æ­æ± åå±æ¯å¦å®æ
    assign layer_2_ready = line_count == input_line_div;

endmodule
