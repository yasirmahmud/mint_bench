module smart_encoder8 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        enable,
    input  logic        cfg_inv,
    input  logic [7:0]  din,
    output logic [2:0]  code,
    output logic        valid,
    output logic [7:0]  onehot
);

    logic [7:0] din_masked;
    logic [2:0] pre_code;
    logic       pre_valid;

    logic [2:0] code_q;
    logic       valid_q;

    logic [7:0] hist;
    logic [7:0] hist_next;

    logic [7:0] din_and_hist;
    logic [7:0] din_xor_hist;
    logic       parity;
    logic [7:0] onehot_candidate;

    always @(din or enable) begin
        if (enable) begin
            din_masked = cfg_inv ? ~din : din;
        end else begin
            din_masked = 8'h00;
        end
    end

    always_comb begin
        pre_valid = |din_masked;
        if (din_masked[7]) pre_code = 3'd7;
        else if (din_masked[6]) pre_code = 3'd6;
        else if (din_masked[5]) pre_code = 3'd5;
        else if (din_masked[4]) pre_code = 3'd4;
        else if (din_masked[3]) pre_code = 3'd3;
        else if (din_masked[2]) pre_code = 3'd2;
        else if (din_masked[1]) pre_code = 3'd1;
        else if (din_masked[0]) pre_code = 3'd0;
    end

    always_comb begin
        din_and_hist = din_masked & hist;
        din_xor_hist = din_masked ^ hist;
    end

    always_comb begin
        parity = ^din_masked;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            code_q <= 3'd0;
            valid_q <= 1'b0;
            hist   <= 8'h00;
        end else begin
            code_q <= pre_code;
            valid_q = pre_valid;
            hist   <= hist_next;
        end
    end

    always_comb begin
        hist_next = (hist & ~din_masked) | (~hist & din_masked);
    end

    always_comb begin
        if (valid_q) begin
            onehot_candidate = 8'h01 << code_q;
        end else begin
            onehot_candidate = 8'h00;
        end
    end

    always_comb begin
        if (parity) begin
            onehot = onehot_candidate;
        end else begin
            onehot = onehot_candidate ^ 8'hFF;
        end
    end

    assign code  = code_q;
    assign valid = valid_q;

endmodule