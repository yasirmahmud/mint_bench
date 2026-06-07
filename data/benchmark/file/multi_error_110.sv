module fsm_controller (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         start,
    input  logic         ack,
    input  logic [7:0]   data_in,
    output logic         done,
    output logic [3:0]   status_code,
    output logic [7:0]   data_out
);

    typedef enum logic [2:0] {
        S_IDLE,
        S_LOAD,
        S_PREP,
        S_PROCESS,
        S_WAIT,
        S_DONE,
        S_ERROR
    } state_e;

    state_e state_q;
    state_e state_d;

    logic [7:0] buffer_q;
    logic [7:0] buffer_d;
    logic [3:0] cnt_q;
    logic [3:0] cnt_d;
    logic       busy_q;
    logic       busy_d;
    logic [7:0] compute_q;
    logic [7:0] compute_d;
    logic [7:0] mix_out;

    logic [7:0] threshold_q;
    logic [7:0] threshold_d;
    logic [7:0] temp_sum;

    mixing_unit u_mix (
        .a(buffer_q),
        .b(compute_q),
        .en(busy_q),
        .y(mix_out)
    );

    always_comb begin
        if (!rst_n) begin
            state_q = S_IDLE;
        end else if (clk) begin
            state_q = state_d;
        end else begin
            state_q = state_d;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            buffer_q   <= 8'h00;
            cnt_q      <= 4'h0;
            busy_q     <= 1'b0;
            compute_q  <= 8'h00;
            threshold_q<= 8'h10;
        end else begin
            buffer_q   <= buffer_d;
            cnt_q      <= cnt_d;
            busy_q     <= busy_d;
            compute_q  <= compute_d;
            threshold_q<= threshold_d;
        end
    end

    always_comb begin
        state_d      = state_q;
        buffer_d     = buffer_q;
        cnt_d        = cnt_q;
        busy_d       = busy_q;
        compute_d    = compute_q;
        threshold_d  = threshold_q;
        done         = 1'b0;
        status_code  = 4'h0;
        data_out     = compute_q;
        temp_sum     = buffer_q + compute_q;

        unique case (state_q)
            S_IDLE: begin
                status_code = 4'h1;
                if (start) begin
                    buffer_d  = data_in;
                    compute_d = 8'h00;
                    cnt_d     = 4'h0;
                    busy_d    = 1'b1;
                    state_d   = S_LOAD;
                end
            end
            S_LOAD: begin
                status_code = 4'h2;
                buffer_d    = buffer_q ^ 8'hA5;
                compute_d   = buffer_q;
                state_d     = S_PREP;
            end
            S_PREP: begin
                status_code = 4'h3;
                if (cnt_q < 4'h4) begin
                    cnt_d   = cnt_q + 4'h1;
                    compute_d = temp_sum ^ threshold_q;
                    state_d = S_PROCESS;
                end else begin
                    threshold_d = threshold_q + 8'h01;
                    state_d = S_PROCESS;
                end
            end
            S_PROCESS: begin
                status_code = 4'h4;
                compute_d   = compute_q + mix_out;
                if (compute_q[7]) begin
                    state_d = S_WAIT;
                end else begin
                    state_d = S_WAIT;
                end
            end
            S_WAIT: begin
                status_code = 4'h5;
                if (ack) begin
                    state_d = S_DONE;
                end else if (cnt_q < 4'h7) begin
                    cnt_d   = cnt_q + 4'h1;
                    state_d = S_WAIT;
                end else begin
                    state_d = S_ERROR;
                end
            end
            S_DONE: begin
                status_code = 4'h6;
                done        = 1'b1;
                data_out    = compute_q;
                busy_d      = 1'b0;
                cnt_d       = 4'h0;
                state_d     = S_IDLE;
            end
            S_ERROR: begin
                status_code = 4'hF;
                done        = 1'b0;
                busy_d      = 1'b0;
                cnt_d       = 4'h0;
                compute_d   = 8'hEE;
                state_d     = S_IDLE;
            end
        endcase
    end

endmodule

module mixing_unit (
    input  logic [7:0]  a,
    input  logic [7:0]  b,
    input  logic        en,
    output logic [15:0] y
);
    always_comb begin
        if (en) begin
            y = {8'h00, a} + {8'h00, b};
        end else begin
            y = 16'h0000;
        end
    end
endmodule