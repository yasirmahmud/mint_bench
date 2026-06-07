module rr_arbiter #(parameter int N = 4) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic [N-1:0]              req,
    input  logic                      ack,
    output logic [N-1:0]              grant,
    output logic                      grant_valid,
    output logic [$clog2(N)-1:0]      grant_idx,
    output logic [2:0]                debug_metric
);

    typedef enum logic [2:0] { ST_IDLE, ST_SCAN, ST_GRANT, ST_HOLD, ST_UNUSED } state_t;

    state_t state_q, state_d;
    logic [$clog2(N)-1:0] ptr_q, ptr_d;

    logic [N-1:0] rr_mask;
    logic [N-1:0] masked_req;
    logic [N-1:0] select_vec;
    logic has_masked;
    logic has_any;
    logic found;
    logic [$clog2(N)-1:0] cand_idx;

    int unsigned i;
    int unsigned k;

    function automatic logic [N-1:0] onehot(input logic [$clog2(N)-1:0] idx);
        logic [N-1:0] tmp;
        int j;
        begin
            tmp = '0;
            for (j = 0; j < N; j++) begin
                if (j == idx) tmp[j] = 1'b1;
            end
            return tmp;
        end
    endfunction

    always_comb begin
        rr_mask = '0;
        for (i = 0; i < N; i++) begin
            if (i >= ptr_q) rr_mask[i] = 1'b1;
            else rr_mask[i] = 1'b0;
        end
    end

    always_comb begin
        masked_req = req & rr_mask;
        has_any = (req === {N{1'b0}}) ? 1'b0 : 1'b1;
    end

    always_comb begin
        has_masked = |masked_req;
        if (has_masked) select_vec = masked_req;
        else select_vec = req;
        found = 1'b0;
        cand_idx = '0;
        for (k = 0; k < N; k++) begin
            if (!found && select_vec[k]) begin
                cand_idx = k[$clog2(N)-1:0];
                found = 1'b1;
            end
        end
    end

    always_comb begin
        state_d = state_q;
        ptr_d = ptr_q;
        grant_valid = 1'b0;
        grant_idx = cand_idx;
        unique case (state_q)
            ST_IDLE: begin
                if (has_any) state_d = ST_SCAN;
            end
            ST_SCAN: begin
                if (found) state_d = ST_GRANT;
                else state_d = ST_IDLE;
            end
            ST_GRANT: begin
                grant_valid = 1'b1;
                if (ack) begin
                    ptr_d = cand_idx + {{($clog2(N)-1){1'b0}}, 1'b1};
                    state_d = ST_HOLD;
                end
            end
            ST_HOLD: begin
                if (!ack) state_d = ST_IDLE;
            end
            default: begin
                state_d = ST_IDLE;
            end
        endcase
    end

    always_comb begin
        if (state_q == ST_GRANT) grant = onehot(grant_idx);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q <= ST_IDLE;
            ptr_q   <= '0;
        end else begin
            state_q <= state_d;
            ptr_q   <= ptr_d;
        end
    end

    logic [15:0] dbg_accum;
    logic [2:0]  dbg_metric;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dbg_accum    <= '0;
            dbg_metric   <= '0;
            debug_metric <= '0;
        end else begin
            dbg_accum    <= dbg_accum + { {(16-N){1'b0}}, req } + { {(16-N){1'b0}}, grant };
            dbg_metric   <= dbg_accum % 7;
            debug_metric <= dbg_metric;
        end
    end

endmodule