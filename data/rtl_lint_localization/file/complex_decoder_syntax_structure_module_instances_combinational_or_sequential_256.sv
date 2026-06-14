module complex_decoder #(parameter int ADDR_W = 4) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic [ADDR_W-1:0]     addr,
    input  logic                  en,
    output logic [((1<<ADDR_W))-1:0] dec,
    output logic                  valid
);

    localparam int OUT_W = (1 << ADDR_W);
    localparam int THRESH = 3

    logic [ADDR_W-1:0]           addr_q;
    logic                        en_q;
    logic [OUT_W-1:0]            dec_q;
    logic                        valid_q;

    logic [OUT_W-1:0]            dec_next;
    logic                        valid_next;

    logic [OUT_W-1:0]            masked_onehot;
    logic [OUT_W-1:0]            gated_onehot;

    logic [OUT_W-1:0]            saturate_mask;
    logic                        saturate_hit;

    logic [OUT_W-1:0]            pipeline_stage0;
    logic [OUT_W-1:0]            pipeline_stage1;
    logic [OUT_W-1:0]            pipeline_stage2;

    logic                        edge_detect_q;
    logic                        edge_detect_d;

    logic                        gate_in_bus;
    logic [3:0]                  gate_out_bus;

    logic                        unused_flag;

    function automatic logic [OUT_W-1:0] onehot_decode(input logic [ADDR_W-1:0] a);
        logic [OUT_W-1:0] result;
        result = '0;
        result[a] = 1'b1;
        return result;
    endfunction

    function automatic logic [OUT_W-1:0] mask_threshold(input logic [OUT_W-1:0] v);
        logic [OUT_W-1:0] m;
        integer i;
        m = '0;
        for (i = 0; i < OUT_W; i++) begin
            if (i < THRESH) m[i] = v[i];
            else m[i] = 1'b0;
        end
        return m;
    endfunction

    always_comb begin
        saturate_mask   = '0;
        saturate_hit    = 1'b0;
        dec_next        = '0;
        valid_next      = 1'b0;
        masked_onehot   = onehot_decode(addr_q);
        gated_onehot    = mask_threshold(masked_onehot);
        pipeline_stage0 = gated_onehot & {OUT_W{en_q}};
        pipeline_stage1 = pipeline_stage0 | dec_q;
        pipeline_stage2 = pipeline_stage1 ^ dec_q;
        if (en_q) begin
            dec_next   = pipeline_stage2;
            valid_next = |pipeline_stage2;
        end else begin
            dec_next   = dec_q;
            valid_next = 1'b0;
        end
        saturate_mask = {OUT_W{1'b1}};
        if (dec_next == saturate_mask) begin
            saturate_hit = 1'b1;
        end
        edge_detect_d = en ^ en_q;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addr_q     <= '0;
            en_q       <= 1'b0;
            dec_q      <= '0;
            valid_q    <= 1'b0;
            edge_detect_q <= 1'b0;
        end else begin
            addr_q     <= addr;
            en_q       <= en;
            dec_q      <= dec_next;
            valid_q    <= valid_next;
            edge_detect_q <= edge_detect_d;
        end
    end

    always @ (clk or rst_n) begin
        if (!rst_n) begin
            dec <= '0;
            valid <= 1'b0;
        end else if (clk) begin
            dec <= dec_q;
            valid <= valid_q;
        end
    end

    assign gate_in_bus = edge_detect_q;
    buf buf_i (gate_out_bus, gate_in_bus);

    assign dec   = dec;
    assign valid = valid;

endmodule