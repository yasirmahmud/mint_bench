module arbiter_rr #(
    parameter int WIDTH = 4,
    parameter int IDXW  = $clog2(WIDTH)
) (
    input  logic                   clk,
    input  logic                   rst,
    input  logic [WIDTH-1:0]       req,
    input  logic                   lock,
    output logic [WIDTH-1:0]       grant,
    output logic                   grant_valid,
    output logic [IDXW-1:0]        grant_idx
);

    logic [WIDTH-1:0] pre_req;
    logic [WIDTH-1:0] arb_vec;
    logic [WIDTH-1:0] grant_candidate;
    logic [IDXW-1:0]  grant_idx_d;
    logic             grant_issue;
    logic             grant_valid_d;
    logic [WIDTH-1:0] grant_next;
    logic [WIDTH-1:0] prev_grant;
    logic [WIDTH-1:0] mask_reg;
    logic [WIDTH-1:0] hold_vec;

    always @(req or lock) begin
        if (lock) begin
            pre_req = req;
        end else begin
            pre_req = req & mask_reg;
        end
    end

    always_comb begin
        int unsigned i;
        arb_vec = '0;
        grant_candidate = '0;
        grant_idx_d = '0;
        if (lock) begin
            hold_vec = prev_grant;
            arb_vec = hold_vec & req;
        end else begin
            if (pre_req != '0) begin
                arb_vec = pre_req;
            end else begin
                arb_vec = req;
            end
        end
        for (i = 0; i < WIDTH; i = i + 1) begin
            if (arb_vec[i]) begin
                grant_candidate = '0;
                grant_candidate[i] = 1'b1;
                grant_idx_d = i[IDXW-1:0];
                break;
            end
        end
        grant_issue   = (arb_vec != '0);
        grant_next    = grant_candidate;
        grant_valid_d = grant_issue;
    end

    always @(clk or rst) begin
        if (rst) begin
            prev_grant  <= '0;
            mask_reg    <= '1;
            grant       <= '0;
            grant_valid <= 1'b0;
            grant_idx   <= '0;
        end else if (clk) begin
            if (grant_valid_d) begin
                prev_grant  <= grant_next;
                grant       <= grant_next;
                grant_valid <= 1'b1;
                grant_idx   <= grant_idx_d;
                if (grant_next != '0) begin
                    mask_reg <= {grant_next[WIDTH-2:0], grant_next[WIDTH-1]};
                end else begin
                    mask_reg <= mask_reg;
                end
            end else begin
                grant       <= '0;
                grant_valid <= 1'b0;
            end
        end
    end

endmodule