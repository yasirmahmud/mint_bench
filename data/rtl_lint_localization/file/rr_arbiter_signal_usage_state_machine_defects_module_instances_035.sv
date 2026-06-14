module rr_arbiter (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [3:0]  req_i,
    input  logic        lock_i,
    output logic [3:0]  grant_o,
    output logic        valid_o,
    output logic [1:0]  grant_idx_o
);

    logic unused_debug;

    typedef enum logic [1:0] {
        S_IDLE  = 2'd0,
        S_GRANT = 2'd1,
        S_HOLD  = 2'd2
    } state_t;

    state_t state;
    state_t next_state;

    logic [1:0] ptr_q;
    logic [1:0] ptr_d;

    logic [1:0] curr_idx_q;
    logic [1:0] grant_idx_d;

    logic        valid_q;
    logic        valid_d;

    logic [7:0]  dup8;
    logic [7:0]  sh8;
    logic [3:0]  sh4;
    logic [3:0]  onehot_rot;
    logic [1:0]  off;
    logic [1:0]  ng_idx;
    logic        has_req;

    logic [3:0]  dec_grant;

    always_comb begin
        dup8     = {req_i, req_i};
        sh8      = dup8 >> ptr_q;
        sh4      = sh8[3:0];
        onehot_rot = 4'b0000;
        off      = 2'b00;
        has_req  = |req_i;
        if (sh4[0]) begin
            onehot_rot = 4'b0001;
            off = 2'd0;
        end else if (sh4[1]) begin
            onehot_rot = 4'b0010;
            off = 2'd1;
        end else if (sh4[2]) begin
            onehot_rot = 4'b0100;
            off = 2'd2;
        end else if (sh4[3]) begin
            onehot_rot = 4'b1000;
            off = 2'd3;
        end else begin
            onehot_rot = 4'b0000;
            off = 2'd0;
        end
        ng_idx = (ptr_q + off) & 2'b11;
    end

    always_comb begin
        next_state = state;
        ptr_d      = ptr_q;
        grant_idx_d = curr_idx_q;
        valid_d    = valid_q;
        case (state)
            S_IDLE: begin
                if (has_req) begin
                    next_state  = S_GRANT;
                    grant_idx_d = ng_idx;
                    valid_d     = 1'b1;
                    ptr_d       = (ng_idx + 2'd1) & 2'b11;
                end else begin
                    valid_d     = 1'b0;
                end
            end
            S_GRANT: begin
                if (lock_i) begin
                    next_state  = S_HOLD;
                    grant_idx_d = curr_idx_q;
                    valid_d     = 1'b1;
                end else if (has_req) begin
                    next_state  = S_GRANT;
                    grant_idx_d = ng_idx;
                    valid_d     = 1'b1;
                    ptr_d       = (ng_idx + 2'd1) & 2'b11;
                end else begin
                    next_state  = S_IDLE;
                    valid_d     = 1'b0;
                end
            end
            S_HOLD: begin
                if (!lock_i) begin
                    if (has_req) begin
                        next_state  = S_GRANT;
                        grant_idx_d = ng_idx;
                        valid_d     = 1'b1;
                        ptr_d       = (ng_idx + 2'd1) & 2'b11;
                    end else begin
                        next_state  = S_IDLE;
                        valid_d     = 1'b0;
                    end
                end else begin
                    valid_d     = 1'b1;
                end
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= S_IDLE;
            ptr_q       <= 2'd0;
            curr_idx_q  <= 2'd0;
            valid_q     <= 1'b0;
        end else begin
            state       <= next_state;
            ptr_q       <= ptr_d;
            curr_idx_q  <= grant_idx_d;
            valid_q     <= valid_d;
        end
    end

    grant_decode u_dec (
        .idx_i({1'b0, curr_idx_q}),
        .onehot_o(dec_grant)
    );

    assign grant_idx_o = curr_idx_q;
    assign valid_o     = valid_q;
    assign grant_o     = valid_q ? dec_grant : 4'b0000;

endmodule

module grant_decode (
    input  logic [1:0] idx_i,
    output logic [3:0] onehot_o
);
    always_comb begin
        onehot_o = 4'b0000;
        case (idx_i)
            2'd0: onehot_o = 4'b0001;
            2'd1: onehot_o = 4'b0010;
            2'd2: onehot_o = 4'b0100;
            2'd3: onehot_o = 4'b1000;
            default: onehot_o = 4'b0000;
        endcase
    end
endmodule