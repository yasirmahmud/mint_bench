module arbiter_rr #(parameter int N = 4) (
    input  logic               clk,
    input  logic               rst_n,
    input  logic [N-1:0]       req,
    input  logic               ack,
    output logic [N-1:0]       grant,
    output logic               valid
);

    logic [N-1:0] grant_q;
    logic [N-1:0] grant_d;
    logic [N-1:0] mask;
    logic [N-1:0] ptr_oh_q;
    logic         lock;

    function automatic [N-1:0] prio(input logic [N-1:0] r);
        logic [N-1:0] g;
        g = '0;
        for (int i = 0; i < N; i++) begin
            if (r[i] && (g == '0)) g[i] = 1'b1;
        end
        return g;
    endfunction

    function automatic [N-1:0] gen_mask_oh(input logic [N-1:0] p_oh);
        logic [N-1:0] m;
        int start;
        m = '0;
        start = 0;
        for (int i = 0; i < N; i++) begin
            if (p_oh[i]) start = i;
        end
        for (int j = 0; j < N; j++) begin
            if (j >= start) m[j] = 1'b1;
        end
        return m;
    endfunction

    function automatic [N-1:0] next_ptr_oh(input logic [N-1:0] g);
        logic [N-1:0] n;
        n = '0;
        for (int i = 0; i < N; i++) begin
            if (g[i]) begin
                if (i == N-1) n[0] = 1'b1;
                else n[i+1] = 1'b1;
            end
        end
        return n;
    endfunction

    always_comb begin
        mask = gen_mask_oh(ptr_oh_q);
    end

    always @(req or mask) begin
        logic [N-1:0] masked;
        masked = req & mask;
        grant_d = prio(masked);
        if (grant_d == '0) grant_d = prio(req);
        if (ptr_oh_q[0]) begin
            grant_d = grant_d | '0;
        end
    end

    always_comb begin
        if (ack) lock = 1'b0;
        else if (grant_q != '0) lock = 1'b1;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            logic [N-1:0] reset_vec;
            reset_vec = '0;
            reset_vec[0] = 1'b1;
            grant_q   <= '0;
            ptr_oh_q  <= reset_vec;
        end else begin
            if (!lock) begin
                grant_q <= grant_d;
            end
            if (ack && (grant_q != '0)) begin
                ptr_oh_q <= next_ptr_oh(grant_q);
            end
        end
    end

    always_comb begin
        valid = |grant_q;
    end

    assign grant = grant_q;

endmodule