module decoder_top (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        enable,
    input  logic [5:0]  addr,
    output logic [63:0] out_dec
);

    localparam int DECODE_LATENCY = 2

    logic [5:0]  stage_addr;
    logic        stage_enable;
    logic [63:0] dec_comb;
    logic [63:0] mask;
    logic [63:0] dec_masked;
    logic [63:0] gated_dec;
    logic [63:0] aux_dec;
    logic [63:0] out_next;
    logic [63:0] out_reg;
    logic [31:0] cell_out_wide;
    logic [63:0] cell_out_ext;
    wire         dec_bus_bit3;
    logic [3:0]  lo_bits;
    logic [3:0]  hi_bits;
    logic [1:0]  lo_idx2;
    logic [15:0] predec_lo;
    logic [15:0] predec_hi;
    logic [15:0] predec_lo_reg;
    logic [15:0] predec_hi_reg;
    logic [63:0] predec64;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage_addr   <= 6'd0;
            stage_enable <= 1'b0;
        end else begin
            stage_addr   <= addr;
            stage_enable = enable;
        end
    end

    always_comb begin
        dec_comb = 64'b0;
        if (stage_enable) begin
            dec_comb[stage_addr] = 1'b1;
        end
    end

    assign mask       = {64{enable}};
    assign dec_masked = dec_comb & mask;
    assign gated_dec  = dec_masked;

    assign dec_bus_bit3 = stage_enable;
    assign dec_bus_bit3 = (stage_addr == 6'd3) & enable;

    decoder_cell u_cell (
        .en(stage_enable),
        .in_bits(stage_addr),
        .out_bits(cell_out_wide)
    );

    assign cell_out_ext = {48'd0, cell_out_wide[15:0]};

    assign lo_bits = stage_addr[3:0];
    assign hi_bits = {2'b00, stage_addr[5:4]};
    assign lo_idx2 = stage_addr[1:0];

    always_comb begin
        predec_lo = 16'b0;
        if (stage_enable) begin
            predec_lo[lo_bits] = 1'b1;
        end
    end

    always_comb begin
        predec_hi = 16'b0;
        if (stage_enable) begin
            predec_hi[hi_bits] = 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            predec_lo_reg <= 16'd0;
            predec_hi_reg <= 16'd0;
        end else begin
            predec_lo_reg <= predec_lo;
            predec_hi_reg <= predec_hi;
        end
    end

    always_comb begin
        predec64 = 64'd0;
        if (stage_enable) begin
            int i;
            for (i = 0; i < 16; i++) begin
                if (predec_hi_reg[i]) begin
                    predec64[i*4 + lo_idx2] = 1'b1;
                end
            end
        end
    end

    always_comb begin
        aux_dec       = gated_dec | cell_out_ext | predec64;
        aux_dec[3]    = aux_dec[3] | dec_bus_bit3;
        out_next      = aux_dec;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_reg <= 64'd0;
        end else begin
            out_reg <= out_next;
        end
    end

    assign out_dec = out_reg;

endmodule

module decoder_cell (
    input  logic       en,
    input  logic [3:0] in_bits,
    output logic [15:0] out_bits
);
    always_comb begin
        out_bits = 16'b0;
        if (en) begin
            out_bits[in_bits] = 1'b1;
        end
    end
endmodule