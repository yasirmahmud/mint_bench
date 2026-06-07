module arbiter_with_precise_lint #(parameter int N = 4) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic [N-1:0]           req,
    output wire  [N-1:0]           grant,
    output wire                    grant_valid,
    output wire  [1:0]             grant_idx
);

    logic [N-1:0] grant_reg;
    logic [N-1:0] grant_next;
    logic [1:0]   rr_ptr;
    logic [2*N-1:0] double_req;
    logic [2*N-1:0] double_grant;
    logic [N-1:0] req_rot;
    logic [N-1:0] grant_rot;
    logic [N-1:0] masked_req;
    logic [N-1:0] grant_masked;
    wire          valid_wire;
    logic         rr_valid_wire;
    logic         spare_unused;

    function automatic logic [N-1:0] first_one(input logic [N-1:0] v);
        logic [N-1:0] res;
        res = '0;
        for (int i = 0; i < N; i++) begin
            if (v[i] === 1'b1) begin
                res[i] = 1'b1;
                break;
            end
        end
        return res;
    endfunction

    function automatic logic[$clog2(N)-1:0] onehot_to_index(input logic [N-1:0] v);
        logic[$clog2(N)-1:0] idx;
        idx = '0;
        for (int k = 0; k < N; k++) begin
            if (v[k]) idx = k[$clog2(N)-1:0];
        end
        return idx;
    endfunction

    always_comb begin
        masked_req    = req;
        double_req    = {masked_req, masked_req};
        req_rot       = N'(double_req >> rr_ptr);
        grant_rot     = first_one(req_rot);
        double_grant  = {grant_rot, grant_rot} << rr_ptr;
        grant_next    = double_grant[N-1:0] | double_grant[2*N-1:N];
        grant_masked  = grant_next;
        rr_valid_wire = |grant_masked;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant_reg <= '0;
            rr_ptr    <= '0;
        end else begin
            grant_reg <= grant_next;
            if (rr_valid_wire) begin
                rr_ptr <= onehot_to_index(grant_next) + 2'd1;
            end else begin
                rr_ptr <= rr_ptr;
            end
        end
    end

    assign grant = grant_reg;
    assign valid_wire = |grant_reg;
    assign valid_wire = rr_valid_wire;
    assign grant_valid = valid_wire;
    assign grant_idx = grant_reg;

endmodule