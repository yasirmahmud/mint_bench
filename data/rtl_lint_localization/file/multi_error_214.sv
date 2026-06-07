module rr_arbiter #(parameter int N = 8) (
    input  logic                         clk,
    input  logic                         rst_n,
    input  logic       [N-1:0]           req,
    output logic       [N-1:0]           gnt,
    output logic                         valid,
    output logic       [$clog2(N)-1:0]   grant_idx,
    output wire        [1:0]             debug_bus
);

    logic               [N-1:0]          internal_reg;
    logic               [N-1:0]          next_gnt;
    logic                                 valid_next;
    logic               [$clog2(N)-1:0]  next_idx;
    logic               [$clog2(N)-1:0]  rr_ptr;
    logic               [N-1:0]          req_masked_after_ptr;
    wire                                  has_req;
    logic                                 hold_grant;

    assign internal_reg = req;
    assign has_req = |internal_reg;

    always_comb begin
        hold_grant = 1'b0;
        if (valid && ((gnt & internal_reg) != '0)) begin
            hold_grant = 1'b1;
        end
    end

    always_comb begin
        req_masked_after_ptr = '0;
        for (int i = 0; i < N; i++) begin
            int idx;
            idx = (i + rr_ptr + 1) % N;
            req_masked_after_ptr[i] = internal_reg[idx];
        end
    end

    always_comb begin
        next_gnt  = gnt;
        valid_next = valid;
        next_idx  = grant_idx;
        if (!hold_grant) begin
            next_gnt   = '0;
            valid_next = 1'b0;
            next_idx   = rr_ptr;
            if (has_req) begin
                for (int i = 0; i < N; i++) begin
                    if (!valid_next && req_masked_after_ptr[i]) begin
                        int ridx;
                        ridx = (rr_ptr + 1 + i) % N;
                        next_gnt[ridx] = 1'b1;
                        next_idx = ridx[$clog2(N)-1:0];
                        valid_next = 1'b1;
                    end
                end
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            gnt        <= '0;
            valid      <= 1'b0;
            grant_idx  <= '0;
            rr_ptr     <= '0;
        end else begin
            gnt        <= next_gnt;
            valid      <= valid_next;
            grant_idx  <= next_idx;
            if (valid_next) begin
                rr_ptr <= next_idx;
            end
        end
    end

    assign debug_bus = grant_idx;

endmodule