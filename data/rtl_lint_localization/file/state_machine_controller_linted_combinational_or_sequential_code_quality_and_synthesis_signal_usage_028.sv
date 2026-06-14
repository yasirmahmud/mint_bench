module fsm_controller_linted (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic        stop,
    input  logic        cfg_enable,
    input  logic        cfg_fast,
    input  logic        ext_pause,
    input  logic        ext_error,
    input  logic [7:0]  data_in,
    output logic        done,
    output logic        busy,
    output logic        error_flag,
    output logic [7:0]  out_count
);

    typedef enum logic [2:0] {
        S_IDLE,
        S_LOAD,
        S_PREP,
        S_RUN,
        S_PAUSE,
        S_DONE,
        S_ERR
    } state_t;

    state_t state;
    state_t next_state;

    logic [7:0] count;
    logic [1:0] throttle;
    logic [15:0] debug_shadow;

    assign out_count = count;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            count <= 8'd0;
        end else begin
            case (state)
                S_LOAD: begin
                    count <= data_in;
                end
                S_RUN: begin
                    if (throttle == 2'b00) begin
                        count <= count + 8'd1;
                    end else if (throttle == 2'b01) begin
                        count <= count + 8'd2;
                    end else if (throttle == 2'b10) begin
                        count <= count + 8'd3;
                    end else begin
                        count <= count + 8'd4;
                    end
                end
                S_DONE: begin
                    count <= count;
                end
                default: begin
                    count <= count;
                end
            endcase
        end
    end

    always_comb begin
        throttle = 2'b00;
        if (cfg_enable) begin
            if (cfg_fast) begin
                if (data_in[7]) begin
                    if (data_in[6]) begin
                        if (data_in[5]) begin
                            throttle = 2'b11;
                        end else begin
                            throttle = 2'b10;
                        end
                    end else begin
                        if (data_in[4]) begin
                            throttle = 2'b10;
                        end else begin
                            throttle = 2'b01;
                        end
                    end
                end else begin
                    if (data_in[3]) begin
                        if (data_in[2]) begin
                            throttle = 2'b01;
                        end else begin
                            throttle = 2'b00;
                        end
                    end else begin
                        if (data_in[1]) begin
                            throttle = 2'b01;
                        end else begin
                            throttle = 2'b00;
                        end
                    end
                end
            end else begin
                if (data_in[0]) begin
                    if (ext_pause) begin
                        if (ext_error) begin
                            throttle = 2'b00;
                        end else begin
                            throttle = 2'b01;
                        end
                    end else begin
                        if (start) begin
                            throttle = 2'b01;
                        end else begin
                            throttle = 2'b00;
                        end
                    end
                end else begin
                    throttle = 2'b00;
                end
            end
        end else begin
            throttle = 2'b00;
        end
    end

    always_comb begin
        done       = 1'b0;
        busy       = 1'b0;
        error_flag = 1'b0;
        unique case (state)
            S_IDLE: begin
                if (cfg_enable && start) begin
                    next_state = S_LOAD;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_LOAD: begin
                busy = 1'b1;
                if (ext_error) begin
                    error_flag = 1'b1;
                    next_state = S_ERR;
                end else if (cfg_fast) begin
                    next_state = S_PREP;
                end else begin
                    next_state = S_PREP;
                end
            end
            S_PREP: begin
                busy = 1'b1;
                if (ext_pause) begin
                end else begin
                    next_state = S_RUN;
                end
            end
            S_RUN: begin
                busy = 1'b1;
                if (stop) begin
                    next_state = S_DONE;
                end else if (ext_pause) begin
                    next_state = S_PAUSE;
                end else if (ext_error) begin
                    error_flag = 1'b1;
                    next_state = S_ERR;
                end else begin
                    next_state = S_RUN;
                end
            end
            S_PAUSE: begin
                busy = 1'b0;
                if (ext_error) begin
                    error_flag = 1'b1;
                    next_state = S_ERR;
                end else if (!ext_pause && cfg_enable) begin
                    next_state = S_RUN;
                end else begin
                    next_state = S_PAUSE;
                end
            end
            S_DONE: begin
                done = 1'b1;
                if (start) begin
                    next_state = S_LOAD;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_ERR: begin
                error_flag = 1'b1;
                if (!ext_error) begin
                    next_state = S_IDLE;
                end else begin
                    next_state = S_ERR;
                end
            end
        endcase
    end

endmodule