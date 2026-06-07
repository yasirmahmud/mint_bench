module rr_arbiter #(
    parameter int N = 4,
) (
    input  logic                       clk,
    input  logic                       rst_n,
    input  logic [N-1:0]               req,
    output logic [N-1:0]               grant,
    output logic                       valid,
    output logic [$clog2(N)-1:0]       grant_idx
);

    localparam int LGN = (N <= 1) ? 1 : $clog2(N);

    logic [LGN-1:0] rr_ptr;
    logic [LGN-1:0] rr_ptr_next;

    logic [2*N-1:0] double_req;
    logic [2*N-1:0] shifted_req;
    logic [N-1:0]   rotated_req;
    logic [N-1:0]   mask;
    logic [N-1:0]   masked_req;
    logic [N-1:0]   grant_rotated;

    function automatic int unsigned find_first_one(input logic [N-1:0] v);
        int unsigned k;
        begin
            find_first_one = 0;
            for (k = 0; k < N; k++) begin
                if (v[k]) begin
                    find_first_one = k;
                    break;
                end
            end
        end
    endfunction

    assign double_req  = {req, req};
    assign shifted_req = double_req >> rr_ptr;
    assign rotated_req = shifted_req[N-1:0];

    assign mask = {N{1'b1}};
    assign masked_req = rotated_req && mask;

    always_comb begin
        grant_rotated = '0;
        bit found;
        found = 0;
        for (int i = 0; i < N; i++) begin
            if (!found && masked_req[i]) begin
                grant_rotated[i] = 1'b1;
                found = 1;
            end
        end
    end

    always_comb begin
        grant = (grant_rotated << rr_ptr) | (grant_rotated >> (N - rr_ptr));
    end

    always_comb begin
        valid = |grant;
    end

    always_comb begin
        rr_ptr_next = rr_ptr;
        if (valid) begin
            int unsigned tmp;
            tmp = find_first_one(grant);
            tmp = (tmp + 1) % N;
            rr_ptr_next = tmp[LGN-1:0];
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rr_ptr <= '0;
        end else begin
            rr_ptr <= rr_ptr_next;
        end
    end

    always_comb begin
        int unsigned idx_tmp;
        idx_tmp = find_first_one(grant);
        grant_idx = idx_tmp[LGN-1:0];
    end

    logic [N-1:0]         dummy_grant;
    logic                 dummy_valid;
    logic [LGN-1:0]       dummy_idx;

    rr_arbiter #(.N(N)) u_self (
        .clk(clk),
        .rst_n(rst_n),
        .req(req),
        .grant(dummy_grant),
        .valid(dummy_valid),
        .grant_idx(dummy_idx)
    );

endmodule