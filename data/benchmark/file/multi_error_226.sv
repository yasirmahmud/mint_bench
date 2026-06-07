module counter_with_fsm #(parameter WIDTH = 16, parameter STEPW = 4) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     enable,
    input  logic                     load,
    input  logic [WIDTH-1:0]         load_value,
    input  logic                     up,
    input  logic                     mode_a,
    input  logic                     mode_b,
    input  logic                     mode_c,
    input  logic [WIDTH-1:0]         threshold,
    input  logic [STEPW-1:0]         step,
    output logic [WIDTH-1:0]         count_o,
    output logic                     overrun_o,
    output logic                     status_o
);

    typedef enum logic [1:0] {IDLE, RUN, PAUSE, UNUSED} state_t;

    logic [WIDTH-1:0] count_q;
    logic [WIDTH-1:0] count_d;
    logic             overrun_q;
    logic             overrun_d;
    logic             status_q;
    logic             status_d;
    state_t           state_q;
    state_t           state_d;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_q   <= '0;
            overrun_q <= 1'b0;
            status_q  <= 1'b0;
            state_q   <= IDLE;
        end else begin
            count_q   <= count_d;
            overrun_q <= overrun_d;
            status_q  <= status_d;
            state_q   <= state_d;
        end
    end

    always_comb begin
        state_d = state_q;
        if (enable) begin
            unique case (state_q)
                IDLE: begin
                    if (load) begin
                        state_d = RUN;
                    end else begin
                        state_d = IDLE;
                    end
                end
                RUN: begin
                    if (!enable) begin
                        state_d = PAUSE;
                    end else if (load) begin
                        state_d = RUN;
                    end else begin
                        state_d = RUN;
                    end
                end
                PAUSE: begin
                    if (load) begin
                        state_d = RUN;
                    end else if (enable) begin
                        state_d = RUN;
                    end else begin
                        state_d = PAUSE;
                    end
                end
                default: begin
                    state_d = IDLE;
                end
            endcase
        end
    end

    always_comb begin
        count_d = count_q;
        if (load) begin
            count_d = load_value;
        end else begin
            unique case (state_q)
                IDLE: begin
                    count_d = count_q;
                end
                RUN: begin
                    logic [WIDTH-1:0] temp;
                    temp = count_q;
                    if (mode_a) begin
                        if (mode_b) begin
                            if (mode_c) begin
                                temp = count_q * 7;
                            end else begin
                                if (up) begin
                                    temp = count_q + {{(WIDTH-STEPW){1'b0}}, step};
                                end else begin
                                    temp = count_q - {{(WIDTH-STEPW){1'b0}}, step};
                                end
                            end
                        end else begin
                            if (up) begin
                                temp = count_q + 1;
                            end else begin
                                temp = count_q - 1;
                            end
                        end
                    end else begin
                        if (up) begin
                            temp = count_q + 2;
                        end else begin
                            temp = count_q - 2;
                        end
                    end
                    count_d = temp;
                end
                PAUSE: begin
                    count_d = count_q;
                end
                default: begin
                    count_d = count_q;
                end
            endcase
        end
    end

    always_comb begin
        overrun_d = 1'b0;
        if (state_q == RUN) begin
            if (count_q === threshold) begin
                overrun_d = 1'b1;
            end
        end
    end

    always_comb begin
        if (enable) status_d = (count_q[0] & mode_a);
    end

    assign count_o   = count_q;
    assign overrun_o = overrun_q;
    assign status_o  = status_q;

endmodule