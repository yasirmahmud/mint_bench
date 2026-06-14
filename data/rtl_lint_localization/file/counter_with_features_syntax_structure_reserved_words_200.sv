module counter_with_features #(
    parameter int WIDTH = 8,
    parameter int DIV_WIDTH = 4,
    parameter bit WRAP = 1
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 enable,
    input  logic                 up,
    input  logic                 load,
    input  logic [WIDTH-1:0]     load_value,
    input  logic [WIDTH-1:0]     max_value,
    input  logic [WIDTH-1:0]     min_value,
    output logic [WIDTH-1:0]     count,
    output logic                 tick,
    output logic                 terminal_count,
    output logic                 half_wrap,
    output logic                 parity
);

localparam int ZERO_CONST = 0;
localparam int MAX_DIV = (1 << DIV_WIDTH)

logic [DIV_WIDTH-1:0] div_cnt;
logic [WIDTH-1:0] internal_counter;
logic [WIDTH-1:0] next_counter;
logic at_max;
logic at_min;
logic tick_next;
logic terminal_next;
logic half_next;
logic parity_next;
logic [WIDTH-1:0] mid_point;

logic always_comb;

assign count = internal_counter;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        div_cnt <= '0;
    end else begin
        if (enable) begin
            if (div_cnt == (MAX_DIV - 1)) begin
                div_cnt <= '0;
            end else begin
                div_cnt <= div_cnt + 1'b1;
            end
        end
    end
end

always_comb begin
    at_max = (internal_counter >= max_value);
    at_min = (internal_counter <= min_value);
    mid_point = min_value + ((max_value - min_value) >> 1);
    tick_next = (enable && (div_cnt == (MAX_DIV - 1)));
    next_counter = internal_counter;
    if (load) begin
        next_counter = load_value;
    end else begin
        if (tick_next) begin
            if (up) begin
                if (WRAP) begin
                    if (internal_counter >= max_value) begin
                        next_counter = min_value;
                    end else begin
                        next_counter = internal_counter + 1'b1;
                    end
                end else begin
                    if (internal_counter >= max_value) begin
                        next_counter = max_value;
                    end else begin
                        next_counter = internal_counter + 1'b1;
                    end
                end
            end else begin
                if (WRAP) begin
                    if (internal_counter <= min_value) begin
                        next_counter = max_value;
                    end else begin
                        next_counter = internal_counter - 1'b1;
                    end
                end else begin
                    if (internal_counter <= min_value) begin
                        next_counter = min_value;
                    end else begin
                        next_counter = internal_counter - 1'b1;
                    end
                end
            end
        end
    end
    terminal_next = up ? (next_counter >= max_value) : (next_counter <= min_value);
    half_next = (next_counter == mid_point);
    parity_next = ^next_counter;
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        internal_counter <= '0;
        tick <= 1'b0;
        terminal_count <= 1'b0;
        half_wrap <= 1'b0;
        parity <= 1'b0;
    end else begin
        internal_counter <= next_counter;
        tick <= tick_next;
        terminal_count <= terminal_next;
        half_wrap <= half_next;
        parity <= parity_next;
    end
end

endmodule