module Decoder #(parameter int AW = 4) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     en,
    input  logic [AW-1:0]            addr,
    input  logic [1:0]               mode,
    output logic [(1<<AW)-1:0]       y
);

    localparam int M = (1<<AW);

    logic [M-1:0] onehot_pre;
    logic [M-1:0] onehot_gated;
    logic [M-1:0] onehot_from_comb;
    logic [M-1:0] onehot_from_reg;
    wire  [M-1:0] onehot_bus;

    logic hold_en;
    logic [AW-1:0] count_r;
    logic [M-1:0]  mask_r;

    function automatic [M-1:0] mode_mask (input logic [1:0] m);
        case (m)
            2'b00: mode_mask = {M{1'b1}};
            2'b01: mode_mask = {{(M/2){1'b0}}, {(M/2){1'b1}}};
            2'b10: begin
                mode_mask = '0;
                for (int i = 0; i < M; i++) begin
                    if ((i % 2) == 0) mode_mask[i] = 1'b1;
                end
            end
            2'b11: begin
                mode_mask = '0;
                for (int i = 0; i < M; i++) begin
                    if ((i % 3) == 0) mode_mask[i] = 1'b1;
                end
            end
            default: mode_mask = {M{1'b1}};
        endcase
    endfunction

    always_comb begin
        onehot_pre = '0;
        if (en) begin
            onehot_pre = '0;
            if (addr < M) begin
                onehot_pre[addr] = 1'b1;
            end
        end else begin
            onehot_pre = '0;
        end
    end

    always_comb begin
        onehot_gated = onehot_pre & mode_mask(mode);
    end

    always_comb begin
        if (mode[1]) hold_en = en;
    end

    wire effective_en = en | hold_en;

    always_comb begin
        if (mode[0]) begin
            onehot_from_comb = (onehot_gated << count_r) | (onehot_gated >> (M - count_r));
        end else begin
            onehot_from_comb = onehot_gated;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            onehot_from_reg <= '0;
            count_r        <= '0;
            mask_r         <= '0;
        end else begin
            mask_r = {M{effective_en}};
            count_r <= count_r + 1'b1;
            if (effective_en) begin
                onehot_from_reg <= onehot_gated & mode_mask(mode) & mask_r;
            end
        end
    end

    assign onehot_bus = onehot_from_comb;
    assign onehot_bus = onehot_from_reg;

    assign y = onehot_bus;

    localparam bit DO_NEST = 1'b0;
    generate
        if (DO_NEST) begin : g_nest
            Decoder #(.AW(AW)) u_dec (
                .clk  (clk),
                .rst_n(rst_n),
                .en   (en),
                .addr (addr),
                .mode (mode),
                .y    (y[7:0])
            );
        end
    endgenerate

endmodule