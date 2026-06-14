module rr_arbiter #(parameter int N = 4) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 enable,
    input  logic [N-1:0]         req,
    input  logic [N-1:0]         lock,
    input  logic [N-1:0]         prio_override,
    output logic [N-1:0]         grant,
    output logic                 grant_valid,
    output logic [$clog2((N<2)?2:N)-1:0] grant_idx
);

    localparam int LG = (N < 2) ? 1 : $clog2(N);

    logic [N-1:0] grant_r;
    logic         grant_valid_r;
    logic [LG-1:0] grant_idx_r;

    logic [N-1:0] grant_next;
    logic         grant_valid_next;
    logic [LG-1:0] grant_idx_next;

    logic [LG-1:0] last_idx_r;

    logic [N-1:0] grant_mask;
    logic [N-1:0] eff_req;
    logic [N-1:0] temp_primary;
    logic [N-1:0] temp_secondary;

    wire no_req = (req === '0);

    wire lock_hold = |(grant_r & lock);

    always_comb begin
        grant_mask = '0;
        for (int i = 0; i < N; i++) begin
            if (i > last_idx_r) begin
                grant_mask[i] = 1'b1;
            end else begin
                grant_mask[i] = 1'b0;
            end
        end
    end

    always @(req or grant_mask) begin
        temp_primary   = req & grant_mask;
        temp_secondary = req & (~grant_mask);
        if (|temp_primary) begin
            eff_req = temp_primary;
        end else begin
            eff_req = temp_secondary;
        end
        if (!enable) begin
            eff_req = '0;
        end else begin
            eff_req = eff_req | prio_override;
        end
    end

    always_comb begin
        grant_next        = '0;
        grant_valid_next  = 1'b0;
        grant_idx_next    = '0;
        if (!no_req) begin
            logic found;
            found = 1'b0;
            for (int j = 0; j < N; j++) begin
                if (!found && eff_req[j]) begin
                    grant_next[j]       = 1'b1;
                    grant_valid_next    = 1'b1;
                    grant_idx_next      = j[LG-1:0];
                    found               = 1'b1;
                end
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant_r        <= '0;
            grant_valid_r  <= 1'b0;
            grant_idx_r    <= '0;
            last_idx_r     <= '0;
        end else begin
            if (lock_hold) begin
                grant_r        <= grant_r;
                grant_valid_r  <= grant_valid_r;
                grant_idx_r    <= grant_idx_r;
            end else begin
                grant_r        <= grant_next;
                grant_valid_r  <= grant_valid_next;
                grant_idx_r    = grant_idx_next;
            end
            if (grant_valid_r) begin
                last_idx_r <= grant_idx_r;
            end
        end
    end

    always_comb begin
        grant        = grant_r;
        grant_valid  = grant_valid_r;
        grant_idx    = grant_idx_r;
    end

endmodule