module counter_fsm #(parameter int WIDTH = 8) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      en,
    input  logic                      up,
    input  logic                      load,
    input  logic [WIDTH-1:0]          load_value,
    input  logic [WIDTH-1:0]          max_value,
    output logic [WIDTH-1:0]          count,
    output logic                      at_max,
    output logic                      active
);

localparam logic [WIDTH-1:0] ZERO_VALUE = '0

typedef enum logic [2:0] {S_IDLE, S_COUNT_UP, S_COUNT_DOWN, S_SATURATED, S_UNUSED} state_e;

logic [WIDTH-1:0]          count_q;
state_e                     state_q;
state_e                     state_d;
logic                       inc;
logic                       dec;
logic                       load_en;
logic                       hit_top;
logic                       hit_bottom;

always_comb begin
    hit_top    = (count_q >= max_value);
    hit_bottom = (count_q == ZERO_VALUE);
end

assign at_max = hit_top;
assign active = (state_q != S_IDLE);

always_comb begin
    state_d = state_q;
    inc     = 1'b0;
    dec     = 1'b0;
    load_en = 1'b0;

    unique case (state_q)
        S_IDLE: begin
            if (load) begin
                load_en = 1'b1;
                if (en) begin
                    if (up) begin
                        state_d = S_COUNT_UP;
                    end else begin
                        state_d = S_COUNT_DOWN;
                    end
                end
            end else if (en) begin
                if (up) begin
                    state_d = S_COUNT_UP;
                end else begin
                    state_d = S_COUNT_DOWN;
                end
            end
        end

        S_COUNT_UP: begin
            if (!en) begin
                state_d = S_IDLE;
            end else if (hit_top) begin
                state_d = S_SATURATED;
            end else begin
                inc = 1'b1;
            end
        end

        S_COUNT_DOWN: begin
            if (!en) begin
                state_d = S_IDLE;
            end else if (hit_bottom) begin
                state_d = S_SATURATED;
            end else begin
                dec = 1'b1;
            end
        end

        S_SATURATED: begin
            if (!en) begin
                state_d = S_IDLE;
            end else if (load) begin
                load_en = 1'b1;
                if (up && !hit_top) begin
                    state_d = S_COUNT_UP;
                end else if (!up && !hit_bottom) begin
                    state_d = S_COUNT_DOWN;
                end else begin
                    state_d = S_SATURATED;
                end
            end else begin
                if (up && !hit_top) begin
                    state_d = S_COUNT_UP;
                end else if (!up && !hit_bottom) begin
                    state_d = S_COUNT_DOWN;
                end
            end
        end

        default: begin
            state_d = S_IDLE;
        end
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state_q <= S_IDLE;
        count_q <= '0;
    end else begin
        state_q <= state_d;
        if (load_en) begin
            count_q <= load_value;
        end else if (inc) begin
            if (count_q < max_value) begin
                count_q <= count_q + {{(WIDTH-1){1'b0}}, 1'b1};
            end else begin
                count_q <= count_q;
            end
        end else if (dec) begin
            if (count_q > ZERO_VALUE) begin
                count_q <= count_q - {{(WIDTH-1){1'b0}}, 1'b1};
            end else begin
                count_q <= count_q;
            end
        end else begin
            count_q <= count_q;
        end
    end
end

assign count = count_q;

endmodule