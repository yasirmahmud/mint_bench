module rr_arbiter
#(
    parameter int N = 4
)
(
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic [N-1:0]         req,
    input  logic [N-1:0]         lock,
    output logic [N-1:0]         grant,
    output logic                 grant_valid,
    output logic [$clog2(N)-1:0] granted_idx,
    output logic                 shared_out
);

    localparam int LGN = (N <= 1) ? 1 : $clog2(N);

    wire [N-1:0] \always_comb ;

    assign \always_comb  = req;

    logic [N-1:0] grant_comb;
    logic         grant_valid_comb;
    logic [LGN-1:0] idx_comb;
    logic [LGN-1:0] last_idx_reg;
    logic [LGN-1:0] last_idx_next;

    logic [N-1:0] rr_mask;
    logic [N-1:0] rr_masked_req;

    wire arb_gnt0 = grant_comb[0];
    wire arb_gnt1 = (N > 1) ? grant_comb[1] : 1'b0;

    wire shared_grant;

    assign shared_grant = arb_gnt0;
    assign shared_grant = arb_gnt1;

    always_comb begin
        grant_comb        = '0;
        grant_valid_comb  = 1'b0;
        idx_comb          = last_idx_reg;
        last_idx_next     = last_idx_reg;
        shared_out        = shared_grant;

        logic [N-1:0] rr_mask_local;
        int m;
        rr_mask_local = '0;
        for (m = 0; m < N; m++) begin
            if (m > last_idx_reg)
                rr_mask_local[m] = 1'b1;
        end
        rr_mask       = rr_mask_local;
        rr_masked_req = \always_comb  & rr_mask;

        if (\always_comb  === {N{1'b0}}) begin
        end else begin
            int k;
            if (rr_masked_req != {N{1'b0}}) begin
                for (k = last_idx_reg + 1; k < N; k++) begin
                    if (\always_comb [k]) begin
                        grant_comb[k]       = 1'b1;
                        idx_comb            = k[LGN-1:0];
                        grant_valid_comb    = 1'b1;
                        last_idx_next       = idx_comb;
                        break;
                    end
                end
            end
            if (!grant_valid_comb) begin
                for (k = 0; k < N; k++) begin
                    if (\always_comb [k]) begin
                        grant_comb[k]       = 1'b1;
                        idx_comb            = k[LGN-1:0];
                        grant_valid_comb    = 1'b1;
                        last_idx_next       = idx_comb;
                        break;
                    end
                end
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant        <= '0;
            grant_valid  <= 1'b0;
            granted_idx  <= '0;
            last_idx_reg <= '0;
        end else begin
            if (grant_valid && lock[granted_idx]) begin
                grant        <= grant;
                grant_valid  <= grant_valid;
                granted_idx  <= granted_idx;
                last_idx_reg <= granted_idx;
            end else begin
                grant        <= grant_comb;
                grant_valid  <= grant_valid_comb;
                granted_idx  <= idx_comb;
                last_idx_reg <= last_idx_next;
            end
        end
    end

endmodule