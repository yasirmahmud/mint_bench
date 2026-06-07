module rr_arbiter #(parameter int N = 8) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic [N-1:0]             req,
    input  logic [N-1:0]             mask,
    input  logic                     hold,
    output logic [N-1:0]             grant,
    output logic                     grant_valid,
    output logic [$clog2(N)-1:0]     grant_idx
);

    logic [N-1:0]                     fixed_req;
    logic [N-1:0]                     fixed_grant;
    logic [$clog2(N)-1:0]             fixed_idx;

    logic [N-1:0]                     rr_grant;
    logic [$clog2(N)-1:0]             rr_idx;

    logic [N-1:0]                     grant_reg;
    logic [N-1:0]                     grant_next;

    logic                             grant_valid_reg;
    logic                             grant_valid_next;

    logic [$clog2(N)-1:0]             grant_idx_reg;
    logic [$clog2(N)-1:0]             grant_idx_next;

    logic [$clog2(N)-1:0]             rr_ptr;
    logic [$clog2(N)-1:0]             rr_ptr_next;

    logic                             lock_reg;
    logic                             lock_next;

    logic                             any_masked;

    always_comb begin
        fixed_req   = req & mask;
        fixed_grant = '0;
        fixed_idx   = '0;
        if (fixed_req[0]) begin
            fixed_grant[0] = 1'b1;
            fixed_idx      = '0;
        end else if (fixed_req[1]) begin
            fixed_grant[1] = 1'b1;
            fixed_idx      = 1;
        end else if (fixed_req[2]) begin
            fixed_grant[2] = 1'b1;
            fixed_idx      = 2;
        end else if (fixed_req[3]) begin
            fixed_grant[3] = 1'b1;
            fixed_idx      = 3;
        end else if (fixed_req[4]) begin
            fixed_grant[4] = 1'b1;
            fixed_idx      = 4;
        end else if (fixed_req[5]) begin
            fixed_grant[5] = 1'b1;
            fixed_idx      = 5;
        end else if (fixed_req[6]) begin
            fixed_grant[6] = 1'b1;
            fixed_idx      = 6;
        end else if (fixed_req[7]) begin
            fixed_grant[7] = 1'b1;
            fixed_idx      = 7;
        end
    end

    always_comb begin
        rr_grant = '0;
        rr_idx   = '0;
        int found;
        found = 0;
        for (int k = 0; k < N; k++) begin
            int idx_temp;
            idx_temp = rr_ptr + k;
            if (idx_temp >= N) idx_temp = idx_temp - N;
            if (!found && req[idx_temp]) begin
                rr_grant[idx_temp] = 1'b1;
                rr_idx             = idx_temp[$clog2(N)-1:0];
                found              = 1;
            end
        end
    end

    always_comb begin
        any_masked       = |fixed_req;
        grant_next       = grant_reg;
        grant_idx_next   = grant_idx_reg;
        grant_valid_next = grant_valid_reg;
        rr_ptr_next      = rr_ptr;
        if (lock_reg) begin
            grant_next       = grant_reg;
            grant_idx_next   = grant_idx_reg;
            grant_valid_next = grant_valid_reg;
            rr_ptr_next      = rr_ptr;
        end else if (any_masked) begin
            grant_next       = fixed_grant;
            grant_idx_next   = fixed_idx;
            grant_valid_next = |fixed_grant;
            if (grant_valid_next) begin
                if (grant_idx_next == N-1) rr_ptr_next = '0;
                else rr_ptr_next = grant_idx_next + 1;
            end
        end else begin
            grant_next       = rr_grant;
            grant_idx_next   = rr_idx;
            grant_valid_next = |rr_grant;
            if (grant_valid_next) begin
                if (grant_idx_next == N-1) rr_ptr_next = '0;
                else rr_ptr_next = grant_idx_next + 1;
            end
        end
    end

    always_comb begin
        if (hold && grant_valid_next) lock_next = 1'b1;
        else if (!hold && !grant_valid_next) lock_next = 1'b0;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant_reg        <= '0;
            grant_valid_reg  <= 1'b0;
            grant_idx_reg    <= '0;
            rr_ptr           <= '0;
            lock_reg         <= 1'b0;
        end else begin
            grant_reg        <= grant_next;
            grant_valid_reg  <= grant_valid_next;
            grant_idx_reg    <= grant_idx_next;
            rr_ptr           <= rr_ptr_next;
            lock_reg         <= lock_next;
        end
    end

    assign grant       = grant_reg;
    assign grant_valid = grant_valid_reg;
    assign grant_idx   = grant_idx_reg;

endmodule