module counter_with_fsm #(
    parameter int unsigned WIDTH = 8,
    parameter logic [WIDTH-1:0] MAX_VALUE = {WIDTH{1'b1}}
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   up,
    input  logic                   load,
    input  logic [WIDTH-1:0]       load_data,
    input  logic                   soft_clear,
    input  logic [WIDTH-1:0]       threshold,
    output logic [WIDTH-1:0]       count_out,
    output logic                   hit_threshold,
    output logic                   pulse,
    output logic                   active
);

typedef enum logic [1:0] { S_IDLE, S_RUN, S_TERM } state_e;
state_e state_q;
state_e state_d;

logic [WIDTH-1:0] count_q;
logic [WIDTH-1:0] count_d;

logic at_max;
logic at_min;
logic can_count;

logic sticky_hit_q;
logic sticky_hit_d;

assign at_max = (count_q == MAX_VALUE);
assign at_min = (count_q == '0);
assign count_out = count_q;
assign active = (state_q != S_IDLE);
assign hit_threshold = sticky_hit_q;

always_comb begin
    can_count = enable;
    if (up) begin
        can_count = can_count & ~at_max;
    end else begin
        can_count = can_count & ~at_min;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state_q <= S_IDLE;
        count_q <= '0;
        sticky_hit_q <= 1'b0;
    end else begin
        state_q <= state_d;
        count_q <= count_d;
        sticky_hit_q <= sticky_hit_d;
    end
end

always_comb begin
    state_d = state_q;
    count_d = count_q;
    sticky_hit_d = sticky_hit_q;
    pulse = 1'b0;
    unique case (state_q)
        S_IDLE: begin
            if (load) begin
                count_d = load_data;
            end
            if (enable) begin
                state_d = S_RUN;
            end
        end
        S_RUN: begin
            if (load) begin
                count_d = load_data;
            end else if (can_count) begin
                if (up) begin
                    count_d = count_q + 1'b1;
                end else begin
                    count_d = count_q - 1'b1;
                end
            end
            if ((up && at_max) || (!up && at_min)) begin
                state_d = S_TERM;
            end else if (!enable) begin
                state_d = S_IDLE;
            end
            if (count_d == threshold) begin
                pulse = 1'b1;
                sticky_hit_d = 1'b1;
            end
        end
    endcase
end

always_comb begin
    logic [WIDTH-1:0] tmp;
    tmp = count_q;
    if (soft_clear) begin
        tmp = '0;
    end
    count_q = tmp;
end

endmodule