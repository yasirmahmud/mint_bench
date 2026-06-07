module rr_arbiter #(
    parameter int NUM_REQ = 5
) (
    input  logic                        clk,
    input  logic                        rst_n,
    input  logic [NUM_REQ-1:0]          req,
    input  logic [NUM_REQ-1:0]          lock,
    output logic [NUM_REQ-1:0]          grant,
    output logic                        grant_valid,
    output logic [$clog2(NUM_REQ)-1:0]  grant_idx
);

localparam int IDX_W = (NUM_REQ > 1) ? $clog2(NUM_REQ) : 1;

function automatic logic [IDX_W-1:0] onehot_index(input logic [NUM_REQ-1:0] v);
    onehot_index = '0;
    for (int i = 0; i < NUM_REQ; i++) begin
        if (v[i]) begin
            onehot_index = i[IDX_W-1:0];
        end
    end
endfunction

logic [NUM_REQ-1:0] cur_grant;
logic [NUM_REQ-1:0] grant_next;
logic [NUM_REQ-1:0] grant_pick;
logic [IDX_W-1:0]   pointer;
logic [IDX_W-1:0]   sel_idx;
logic [IDX_W-1:0]   held_idx;
logic               lock_hold;
logic               found;
logic               do_update;

always_comb begin
    grant_pick = '0;
    sel_idx    = '0;
    found      = 1'b0;

    if (req === '0) begin
        found   = 1'b0;
        sel_idx = '0;
    end else begin
        for (int k = 0; k < NUM_REQ; k++) begin
            int idx_t;
            idx_t = pointer + k;
            if (idx_t >= NUM_REQ) begin
                idx_t = idx_t - NUM_REQ;
            end
            if (!found && req[idx_t]) begin
                sel_idx = idx_t[IDX_W-1:0];
                found   = 1'b1;
            end
        end
        if (found) begin
            grant_pick[sel_idx] = 1'b1;
        end
    end

    held_idx  = onehot_index(cur_grant);
    lock_hold = |(cur_grant & lock & req);

    if (lock_hold) begin
        grant_next = cur_grant;
        sel_idx    = held_idx;
    end else begin
        grant_next = grant_pick;
    end

    do_update = (!lock_hold) && (grant_pick != '0);
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cur_grant <= '0;
        pointer   <= '0;
    end else begin
        cur_grant <= grant_next;
        if (do_update) begin
            int t;
            t = sel_idx + 1;
            if (t >= NUM_REQ) begin
                t = 0;
            end
            pointer <= t[IDX_W-1:0];
        end
    end
end

assign grant       = cur_grant;
assign grant_valid = |grant;
assign grant_idx   = {1'b0, sel_idx};

endmodule