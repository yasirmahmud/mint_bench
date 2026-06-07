module complex_counter #(parameter int WIDTH = 8) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   load,
    input  logic [15:0]            load_value,
    input  logic                   up_down,
    input  logic [3:0]             mode_sel,
    output logic [WIDTH-1:0]       count,
    output logic                   terminal,
    output logic [15:0]            wide_out
);

    typedef enum logic [1:0] {
        S_IDLE,
        S_LOAD,
        S_RUN,
        S_PAUSE
    } state_t;

    localparam logic [WIDTH-1:0] MAX_VAL = {WIDTH{1'b1}};

    state_t                       state;
    state_t                       state_n;

    logic [WIDTH-1:0]             count_q;
    logic [WIDTH-1:0]             count_d;

    logic [WIDTH:0]               add1;
    logic [WIDTH:0]               sub1;

    logic [3:0]                   hold_mask;

    logic                         terminal_up;
    logic                         terminal_down;

    logic                         unused_flag;

    assign count = count_q;
    assign wide_out = count_q;

    assign terminal_up   = (count_q == MAX_VAL);
    assign terminal_down = (count_q == {WIDTH{1'b0}});
    assign terminal      = up_down ? terminal_up : terminal_down;

    always_comb begin
        hold_mask       = 4'b0000;
        hold_mask[3]    = mode_sel[3] & enable;
        hold_mask[2]    = mode_sel[2] & ~enable;
        hold_mask[1]    = mode_sel[1] ^ up_down;
        hold_mask[0]    = mode_sel[0] | load;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= S_IDLE;
            count_q <= '0;
        end else begin
            state   <= state_n;
            count_q <= count_d;
        end
    end

    always_comb begin
        state_n = state;
        case (state)
            S_IDLE: begin
                if (load) begin
                    state_n = S_LOAD;
                end else if (enable) begin
                    state_n = S_RUN;
                end else begin
                    state_n = S_IDLE;
                end
            end
            S_LOAD: begin
                state_n = S_RUN;
            end
            S_RUN: begin
                if (load) begin
                    state_n = S_LOAD;
                end else if (!enable) begin
                    state_n = S_PAUSE;
                end else begin
                    state_n = S_RUN;
                end
            end
            S_PAUSE: begin
                if (load) begin
                    state_n = S_LOAD;
                end else if (enable) begin
                    state_n = S_RUN;
                end else begin
                    state_n = S_PAUSE;
                end
            end
        endcase
    end

    always_comb begin
        add1    = {1'b0, count_q} + {{WIDTH{1'b0}}, 1'b1};
        sub1    = {1'b0, count_q} - {{WIDTH{1'b0}}, 1'b1};
        count_d = count_q;
        if (state == S_LOAD) begin
            count_d = load_value[WIDTH-1:0];
        end else if (state == S_RUN) begin
            if (mode_sel[3]) begin
                if (up_down) begin
                    if (terminal_up) begin
                        if (hold_mask[2]) begin
                            if (hold_mask[1]) begin
                                count_d = add1[WIDTH-1:0];
                            end else begin
                                count_d = count_q;
                            end
                        end else begin
                            if (hold_mask[0]) begin
                                count_d = add1[WIDTH-1:0];
                            end else begin
                                count_d = add1[WIDTH-1:0];
                            end
                        end
                    end else begin
                        if (enable) begin
                            count_d = add1[WIDTH-1:0];
                        end else begin
                            count_d = count_q;
                        end
                    end
                end else begin
                    if (terminal_down) begin
                        if (hold_mask[3]) begin
                            count_d = count_q;
                        end else begin
                            if (enable) begin
                                count_d = sub1[WIDTH-1:0];
                            end else begin
                                count_d = count_q;
                            end
                        end
                    end else begin
                        if (enable) begin
                            if (hold_mask[1] & hold_mask[0]) begin
                                count_d = sub1[WIDTH-1:0];
                            end else begin
                                count_d = sub1[WIDTH-1:0];
                            end
                        end else begin
                            count_d = count_q;
                        end
                    end
                end
            end else if (mode_sel[2]) begin
                if (up_down) begin
                    count_d = add1[WIDTH-1:0];
                end else begin
                    count_d = sub1[WIDTH-1:0];
                end
            end else if (mode_sel[1]) begin
                if (enable) begin
                    count_d = count_q ^ {WIDTH{1'b1}};
                end else begin
                    count_d = count_q;
                end
            end else if (mode_sel[0]) begin
                count_d = count_q;
            end else begin
                count_d = up_down ? add1[WIDTH-1:0] : sub1[WIDTH-1:0];
            end
        end else if (state == S_PAUSE) begin
            count_d = count_q;
        end else begin
            count_d = count_q;
        end
    end

endmodule