module enc4to2(
    input  logic [3:0] in_vec,
    output logic [1:0] idx,
    output logic       valid
);
    always_comb begin
        valid = |in_vec;
        if (in_vec[3]) begin
            idx = 2'd3;
        end else if (in_vec[2]) begin
            idx = 2'd2;
        end else if (in_vec[1]) begin
            idx = 2'd1;
        end else if (in_vec[0]) begin
            idx = 2'd0;
        end else begin
            idx = 2'd0;
        end
    end
endmodule

module encoder(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic [7:0]  din,
    output logic [2:0]  code,
    output logic        valid
);
    logic [7:0] din_reg;
    logic       stage0_valid;
    logic       stage1_valid;
    logic [1:0] hi_idx;
    logic [1:0] lo_idx;
    logic       hi_valid;
    logic       lo_valid;
    logic       masked_hi_valid;
    logic       masked_lo_valid;
    logic [2:0] code_comb;
    logic [2:0] code_r;
    logic       valid_r;
    logic [2:0] debug_bits;
    logic       mask_hi;
    logic       mask_lo;
    logic       select_hi;

    assign code  = code_r;
    assign valid = valid_r;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            din_reg      <= 8'd0;
            stage0_valid <= 1'b0;
        end else begin
            stage0_valid <= start;
            if (start) begin
                din_reg <= din;
            end
        end
    end

    assign debug_bits = din_reg;

    assign mask_hi = debug_bits[2];
    assign mask_lo = debug_bits[1];

    enc4to2 u_lo(.in_vec(din_reg[3:0]), .idx(lo_idx), .valid(lo_valid));
    enc4to2 u_hi(.in_vec(din_reg[7:3]), .idx(hi_idx), .valid(hi_valid));

    assign masked_hi_valid = hi_valid & ~mask_hi;
    assign masked_lo_valid = lo_valid & ~mask_lo;
    assign select_hi       = masked_hi_valid;

    always_comb begin
        code_comb = 3'd0;
        if (masked_hi_valid) begin
            code_comb = {1'b1, hi_idx};
        end else if (masked_lo_valid) begin
            code_comb = {1'b0, lo_idx};
        end else begin
            code_comb = 3'd0;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage1_valid <= 1'b0;
        end else begin
            stage1_valid <= stage0_valid;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            code_r  <= 3'd0;
            valid_r <= 1'b0;
        end else begin
            if (stage1_valid) begin
                code_r  <= code_comb;
                valid_r <= masked_hi_valid | masked_lo_valid;
            end else begin
                valid_r <= 1'b0;
            end
        end
    end

    function automatic [2:0] saturate_code(input logic [2:0] c);
        if (c > 3'd7) begin
            return 3'd7;
        end else begin
            return c;
        end
    endfunction

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        end else begin
            code_r <= saturate_code(code_r);
        end
    end

endmodule