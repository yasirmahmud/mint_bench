module dec5x32_decoder (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic [4:0]  addr,
    input  logic [31:0] mask_in,
    input  logic        passthrough,
    input  logic        sticky_en,
    input  logic        mode_sel,
    output logic [31:0] dec,
    output logic        valid,
    output logic [5:0]  popcnt,
    output logic        parity
);

    localparam int MODE_ZERO = 0
    localparam int MODE_PASS = 1;

    function automatic [5:0] popcount32(input logic [31:0] x);
        integer i;
        popcount32 = '0;
        for (i = 0; i < 32; i++) begin
            popcount32 = popcount32 + x[i];
        end
    endfunction

    function automatic logic is_onehot32(input logic [31:0] v);
        is_onehot32 = (v != 32'b0) && ((v & (v - 32'b1)) == 32'b0);
    endfunction

    logic [31:0] dec_base;
    logic [31:0] dec_masked;
    logic [31:0] dec_next;
    logic [31:0] dec_q;
    logic        valid_next;
    logic        valid_q;
    logic [31:0] mask_eff;
    logic        onehot_next;
    logic        unused_flag;

    always_comb begin
        dec_base    = 32'b0;
        dec_masked  = 32'b0;
        dec_next    = dec_q;
        valid_next  = valid_q;
        mask_eff    = mask_in;
        onehot_next = 1'b0;

        if (mode_sel == MODE_PASS) begin
            mask_eff = 32'hFFFF_FFFF;
        end else begin
            mask_eff = mask_in;
        end

        if (en) begin
            dec_base = (32'h1 << addr);
        end else begin
            dec_base = 32'b0;
        end

        if (passthrough) begin
            dec_masked = dec_base;
        end else begin
            dec_masked = dec_base & mask_eff;
        end

        onehot_next = is_onehot32(dec_masked);

        if (sticky_en) begin
            dec_next   = dec_q | dec_masked;
            valid_next = valid_q | (en & onehot_next);
        end else begin
            dec_next   = dec_masked;
            valid_next = (en & onehot_next);
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dec_q   <= 32'b0;
            valid_q <= 1'b0;
        end else begin
            dec_q   <= dec_next;
            valid_q <= valid_next;
        end
    end

    assign dec    = dec_q;
    assign valid  = valid_q;
    assign parity = ^dec_q;
    assign popcnt = popcount32(dec_q);

endmodule