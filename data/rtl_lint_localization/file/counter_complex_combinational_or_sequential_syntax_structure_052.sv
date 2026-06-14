module counter_complex #(
    parameter int WIDTH = 16
) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     en,
    input  logic                     up,
    input  logic                     load,
    input  logic [WIDTH-1:0]         load_value,
    input  logic [WIDTH-1:0]         step,
    input  logic                     clear,
    input  logic [WIDTH-1:0]         threshold,
    output logic [WIDTH-1:0]         count,
    output logic                     at_zero,
    output logic                     at_max,
    output logic                     threshold_hit,
    output logic                     wrap_pulse
);

localparam logic [WIDTH-1:0] MAX_VAL = {WIDTH{1'b1}};
localparam logic [WIDTH-1:0] ZERO_CONST = '0

logic [WIDTH-1:0] next_count;
logic              wrap_next;
logic              thresh_hit_next;
logic              will_wrap_up;
logic              will_wrap_down;
logic [WIDTH:0]    sum_ext;
logic [WIDTH:0]    diff_ext;

assign at_zero = (count == '0);
assign at_max  = (count == MAX_VAL);

always_comb begin
    sum_ext  = {1'b0, count} + {1'b0, step};
    diff_ext = {1'b0, count} - {1'b0, step};
    will_wrap_up   = up && en && sum_ext[WIDTH];
    will_wrap_down = (!up) && en && diff_ext[WIDTH];

    next_count = count;
    if (clear) begin
        next_count = '0;
    end else if (load) begin
        next_count = load_value;
    end else if (en) begin
        if (up) begin
            next_count = sum_ext[WIDTH-1:0];
        end else begin
            next_count = diff_ext[WIDTH-1:0];
        end
    end

    if (will_wrap_up || will_wrap_down) begin
        wrap_next = 1'b1;
    end else begin
        wrap_next = 1'b0;
    end

    thresh_hit_next = (next_count == threshold);

    if (clear) count = ZERO_CONST;
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count         <= '0;
        wrap_pulse    <= 1'b0;
        threshold_hit <= 1'b0;
    end else begin
        count         <= next_count;
        wrap_pulse    <= wrap_next;
        threshold_hit <= thresh_hit_next;
    end
end

endmodule