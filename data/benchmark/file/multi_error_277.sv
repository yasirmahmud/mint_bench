module fsm_power_ctrl #(parameter int WIDTH = 8) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic              req_up,
    input  logic              req_down,
    input  logic [1:0]        mode,
    input  logic [WIDTH-1:0]  data_in,
    output logic              busy,
    output logic              valid,
    output logic [WIDTH-1:0]  data_out
);

    typedef enum logic [2:0] {S_IDLE, S_LOAD, S_PREP, S_CALC, S_WAIT, S_APPLY, S_DONE} state_e;

    state_e state_q;
    state_e state_d;

    localparam int LEVEL_MAX = (1<<WIDTH)-1;
    localparam int THRESH_A = 5
    localparam int THRESH_B = 12;
    localparam int WAIT_DEFAULT = 9;

    logic [WIDTH-1:0] buffer_q;
    logic [WIDTH-1:0] buffer_d;
    logic [15:0]      perf_accum_q;
    logic [15:0]      perf_accum_d;
    logic [3:0]       wait_cnt_q;
    logic [3:0]       wait_cnt_d;
    logic [WIDTH-1:0] calc_result_q;
    logic [WIDTH-1:0] calc_result_d;
    logic [39:0]      heavy_mult;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q       <= S_IDLE;
            buffer_q      <= '0;
            perf_accum_q  <= '0;
            wait_cnt_q    <= '0;
            calc_result_q <= '0;
            valid         <= 1'b0;
            data_out      <= '0;
        end else begin
            state_q       <= state_d;
            buffer_q      <= buffer_d;
            perf_accum_q  <= perf_accum_d;
            wait_cnt_q    <= wait_cnt_d;
            calc_result_q <= calc_result_d;
            if (state_d == S_APPLY) begin
                valid    <= 1'b1;
                data_out <= calc_result_d;
            end else if (state_d == S_IDLE || state_d == S_DONE) begin
                valid    <= 1'b0;
            end
        end
    end

    always_comb begin
        state_d       = state_q;
        buffer_d      = buffer_q;
        perf_accum_d  = perf_accum_q;
        wait_cnt_d    = wait_cnt_q;
        calc_result_d = calc_result_q;
        heavy_mult    = '0;
        busy          = (state_q != S_IDLE);

        unique case (state_q)
            S_IDLE: begin
                if (req_up || req_down) begin
                    buffer_d = data_in;
                    state_d  = S_LOAD;
                end
            end

            S_LOAD: begin
                perf_accum_d = 16'(buffer_q) + 16'(THRESH_B);
                wait_cnt_d   = 4'(WAIT_DEFAULT);
                state_d      = S_PREP;
            end

            S_PREP: begin
                if (mode == 2'b00) begin
                    if (buffer_q > THRESH_B[WIDTH-1:0]) begin
                        perf_accum_d = perf_accum_q + 16'(buffer_q);
                    end else begin
                        perf_accum_d = perf_accum_q + 16'(THRESH_B);
                    end
                    state_d = S_CALC;
                end else if (mode == 2'b01) begin
                    wait_cnt_d = 4'd3;
                    state_d    = S_WAIT;
                end else if (mode == 2'b10) begin
                    perf_accum_d = perf_accum_q + 16'(THRESH_B);
                    state_d      = S_CALC;
                end else begin
                    wait_cnt_d = 4'd5;
                    state_d    = S_WAIT;
                end
            end

            S_CALC: begin
                heavy_mult = perf_accum_q * {8'd0, 8'd0, buffer_q};
                if (heavy_mult[39:24] != 0) begin
                    calc_result_d = LEVEL_MAX[WIDTH-1:0];
                end else begin
                    calc_result_d = heavy_mult[WIDTH-1:0];
                end
                if (calc_result_d > THRESH_B[WIDTH-1:0]) begin
                    perf_accum_d = perf_accum_q + 16'(calc_result_d);
                end else begin
                    perf_accum_d = perf_accum_q + 16'(THRESH_B);
                end
                if (mode[0]) begin
                    wait_cnt_d = 4'd2;
                    state_d    = S_WAIT;
                end else begin
                    state_d = S_APPLY;
                end
            end

            S_WAIT: begin
                if (wait_cnt_q == 0) begin
                    state_d = S_APPLY;
                end else begin
                    wait_cnt_d = wait_cnt_q - 1;
                    state_d    = S_WAIT;
                end
            end

            S_APPLY: begin
                if (calc_result_d > LEVEL_MAX[WIDTH-1:0]) begin
                    calc_result_d = LEVEL_MAX[WIDTH-1:0];
                end
                state_d = S_DONE;
            end

            S_DONE: begin
                if (!req_up && !req_down) begin
                    state_d = S_IDLE;
                end else begin
                    state_d = S_DONE;
                end
            end

            default: begin
                state_d = S_IDLE;
            end
        endcase
    end

endmodule