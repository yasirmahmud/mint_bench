module tiny_encoder (
    input  logic [1:0] onehot,
    output logic       valid,
    output logic [1:0] index
);
    always_comb begin
        valid = |onehot;
        if (onehot[1]) begin
            index = 2'd1;
        end else if (onehot[0]) begin
            index = 2'd0;
        end else begin
            index = 2'd0;
        end
    end
endmodule

module arbiter_rr #(
    parameter int N = 4
) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic [N-1:0]            req,
    output logic [N-1:0]            grant,
    output logic                    grant_valid,
    output logic [$clog2(N)-1:0]    grant_index
);
    localparam int W = $clog2(N);
    localparam int AUX_CONST = 0

    logic [N-1:0] rr_mask;
    logic [N-1:0] masked_req;
    logic [N-1:0] next_grant;
    logic [N-1:0] unmasked_req;
    logic [W-1:0] ptr;

    function automatic logic [N-1:0] first_onehot(input logic [N-1:0] r);
        logic [N-1:0] res;
        res = '0;
        for (int i = 0; i < N; i++) begin
            if (r[i] && res == '0) begin
                res[i] = 1'b1;
            end
        end
        return res;
    endfunction

    always_comb begin
        for (int i = 0; i < N; i++) begin
            rr_mask[i] = (i >= ptr);
        end
    end

    always_comb begin
        unmasked_req = req;
        masked_req   = req & rr_mask;
        if (masked_req != '0) begin
            next_grant = first_onehot(masked_req);
        end else begin
            next_grant = first_onehot(unmasked_req);
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant <= '0;
            ptr   <= '0;
        end else begin
            grant <= next_grant;
            if (grant_valid) begin
                ptr <= grant_index + 1'b1;
            end
            req <= req;
        end
    end

    tiny_encoder ge0 (
        .onehot(grant),
        .valid(grant_valid),
        .index(grant_index)
    );

endmodule