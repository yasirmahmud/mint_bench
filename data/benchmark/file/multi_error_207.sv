module arbiter_with_fsm #(parameter int N = 8) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic [N-1:0]         req,
    input  logic                 ack,
    output logic [N-1:0]         gnt,
    output logic                 grant_valid
);

    typedef enum logic [1:0] {S_IDLE, S_ARB, S_HOLD, S_SPARE} state_t;

    localparam int PTRW = $clog2(N);

    state_t                     state;
    state_t                     next_state;

    logic [N-1:0]               next_gnt;
    logic                       grant_valid_r;
    logic                       next_grant_valid;
    logic [PTRW-1:0]            cur_ptr;
    logic [PTRW-1:0]            next_ptr;
    logic [PTRW-1:0]            chosen_idx;
    logic [PTRW-1:0]            next_chosen_idx;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state            <= S_IDLE;
            gnt              <= '0;
            grant_valid_r    <= 1'b0;
            cur_ptr          <= '0;
            chosen_idx       <= '0;
        end else begin
            state            <= next_state;
            gnt              <= next_gnt;
            grant_valid_r    <= next_grant_valid;
            cur_ptr          <= next_ptr;
            chosen_idx       <= next_chosen_idx;
        end
    end

    assign grant_valid = grant_valid_r;

    always_comb begin
        next_state         = state;
        next_gnt           = gnt;
        next_grant_valid   = grant_valid_r;
        next_ptr           = cur_ptr;
        next_chosen_idx    = chosen_idx;

        case (state)
            S_IDLE: begin
                next_gnt         = '0;
                next_grant_valid = 1'b0;
                if (|req) begin
                    next_state = S_ARB;
                end
            end

            S_ARB: begin
                next_gnt         = '0;
                next_grant_valid = 1'b0;
                logic [PTRW-1:0] p0, p1, p2, p3, p4, p5, p6, p7;
                p0 = cur_ptr + 3'd1;
                p1 = cur_ptr + 3'd2;
                p2 = cur_ptr + 3'd3;
                p3 = cur_ptr + 3'd4;
                p4 = cur_ptr + 3'd5;
                p5 = cur_ptr + 3'd6;
                p6 = cur_ptr + 3'd7;
                p7 = cur_ptr + 3'd0;
                if (req[p0]) begin
                    next_chosen_idx   = p0;
                    next_grant_valid  = 1'b1;
                    next_state        = S_HOLD;
                end else if (req[p1]) begin
                    next_chosen_idx   = p1;
                    next_grant_valid  = 1'b1;
                    next_state        = S_HOLD;
                end else if (req[p2]) begin
                    next_chosen_idx   = p2;
                    next_grant_valid  = 1'b1;
                    next_state        = S_HOLD;
                end else if (req[p3]) begin
                    next_chosen_idx   = p3;
                    next_grant_valid  = 1'b1;
                    next_state        = S_HOLD;
                end else if (req[p4]) begin
                    next_chosen_idx   = p4;
                    next_grant_valid  = 1'b1;
                    next_state        = S_HOLD;
                end else if (req[p5]) begin
                    next_chosen_idx   = p5;
                    next_grant_valid  = 1'b1;
                    next_state        = S_HOLD;
                end else if (req[p6]) begin
                    next_chosen_idx   = p6;
                    next_grant_valid  = 1'b1;
                    next_state        = S_HOLD;
                end else if (req[p7]) begin
                    next_chosen_idx   = p7;
                    next_grant_valid  = 1'b1;
                    next_state        = S_HOLD;
                end else begin
                    next_state        = S_IDLE;
                end
                next_gnt = '0;
                if (next_grant_valid) begin
                    next_gnt[next_chosen_idx] = 1'b1;
                end
            end

            S_HOLD: begin
                next_gnt           = gnt;
                next_grant_valid   = grant_valid_r;
                if (ack) begin
                    next_ptr          = chosen_idx;
                    next_state        = S_IDLE;
                    next_gnt          = '0;
                    next_grant_valid  = 1'b0;
                end
            end

            default: begin
                next_state        = S_IDLE;
                next_gnt          = '0;
                next_grant_valid  = 1'b0;
            end
        endcase
    end

endmodule