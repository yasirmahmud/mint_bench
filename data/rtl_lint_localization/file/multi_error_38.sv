module counter_with_exact_two_lint_errors #(parameter int WIDTH = 16) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     enable,
    input  logic                     up,
    input  logic                     load,
    input  logic                     wrap,
    input  logic [WIDTH-1:0]         load_value,
    input  logic [WIDTH-1:0]         step,
    output logic [WIDTH-1:0]         count,
    output logic                     at_max,
    output logic                     at_min,
    output logic                     toggle_flag
);

    localparam logic [WIDTH-1:0] ZERO = {WIDTH{1'b0}};
    localparam logic [WIDTH-1:0] MAX  = {WIDTH{1'b1}};
    localparam logic [WIDTH-1:0] MID  = {{(WIDTH-1){1'b1}}, 1'b0};

    logic [WIDTH-1:0] next_count;
    logic [WIDTH-1:0] masked_step;
    logic [WIDTH-1:0] move_res;
    logic [WIDTH-1:0] add_res;
    logic [WIDTH-1:0] sub_res;
    logic              will_overflow;
    logic              will_underflow;
    logic              cross_mid;
    logic              near_max;
    logic              near_min;
    logic              enable_d;
    logic              hit_load_edge;

    assign add_res = count + step;
    assign sub_res = count - step;
    assign will_overflow = (add_res < count);
    assign will_underflow = (count < step);

    assign move_res = count + masked_step;

    assign at_max = (count == MAX);
    assign at_min = (count == ZERO);

    assign cross_mid = (count == MID);
    assign near_max = ((MAX - count) <= step);
    assign near_min = (count <= step);

    assign hit_load_edge = load & ~enable_d;

    always @(step) begin
        masked_step = up ? step : (~step + 1'b1);
    end

    always_comb begin
        if (load) begin
            next_count = load_value;
        end else if (enable) begin
            if (up) begin
                if (wrap) begin
                    next_count = move_res;
                end else begin
                    if (will_overflow) begin
                        next_count = MAX;
                    end else begin
                        next_count = add_res;
                    end
                end
            end else begin
                if (wrap) begin
                    next_count = move_res;
                end else begin
                    if (will_underflow) begin
                        next_count = ZERO;
                    end else begin
                        next_count = sub_res;
                    end
                end
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count       <= ZERO;
            toggle_flag <= 1'b0;
            enable_d    <= 1'b0;
        end else begin
            count    <= next_count;
            enable_d <= enable;
            if (cross_mid) begin
                toggle_flag <= ~toggle_flag;
            end else if (enable && up && near_max) begin
                toggle_flag <= ~toggle_flag;
            end else if (enable && !up && near_min) begin
                toggle_flag <= ~toggle_flag;
            end else if (hit_load_edge) begin
                toggle_flag <= ~toggle_flag;
            end
        end
    end

endmodule