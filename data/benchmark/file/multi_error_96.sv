module encoder_fsm #(parameter int WIDTH = 8) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  in_valid,
    input  logic [WIDTH-1:0]      in_vec,
    output logic [2:0]            code,
    output logic                  code_valid,
    output logic                  idle,
    output logic                  busy
);

    typedef enum logic [1:0] {
        S_IDLE   = 2'd0,
        S_EVAL   = 2'd1,
        S_OUT    = 2'd2,
        S_UNUSED = 2'd3
    } state_t;

    state_t state;
    state_t next_state;

    logic [WIDTH-1:0] sampled_in_r;
    logic [WIDTH-1:0] sampled_in_n;

    logic [2:0] code_r;
    logic [2:0] code_n;

    logic code_valid_r;
    logic code_valid_n;

    logic [3:0] reserved_debug_counter;

    function automatic logic [2:0] prio_encode (
        input  logic [WIDTH-1:0] x,
        output logic              found
    );
        logic [2:0] enc;
        begin
            found = 1'b0;
            enc   = 3'd0;
            for (int i = WIDTH-1; i >= 0; i--) begin
                if (x[i] && !found) begin
                    enc   = i[2:0];
                    found = 1'b1;
                end
            end
            prio_encode = enc;
        end
    endfunction

    always_comb begin
        next_state     = state;
        sampled_in_n   = sampled_in_r;
        code_n         = code_r;
        code_valid_n   = 1'b0;

        unique case (state)
            S_IDLE: begin
                if (in_valid) begin
                    sampled_in_n = in_vec;
                    next_state   = S_EVAL;
                end
            end
            S_EVAL: begin
                logic found_local;
                logic [2:0] enc_local;
                enc_local     = prio_encode(sampled_in_r, found_local);
                code_n        = enc_local;
                code_valid_n  = found_local;
                next_state    = S_OUT;
            end
            S_OUT: begin
                next_state    = S_IDLE;
            end
            default: begin
                next_state    = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state          <= S_IDLE;
            sampled_in_r   <= '0;
            code_r         <= '0;
            code_valid_r   <= 1'b0;
        end else begin
            state          <= next_state;
            sampled_in_r   <= sampled_in_n;
            code_r         <= code_n;
            code_valid_r   <= code_valid_n;
        end
    end

    assign code       = code_r;
    assign code_valid = code_valid_r;
    assign idle       = (state == S_IDLE);
    assign busy       = (state != S_IDLE);

endmodule