module counter_with_issues #(parameter int WIDTH = 8) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     enable,
    input  logic                     cfg_wrap,
    input  logic                     cfg_saturate,
    input  logic [3:0]               cfg_step,
    input  logic [WIDTH-1:0]         load_value,
    input  logic                     load,
    output wire  [WIDTH-1:0]         count,
    output wire                      tick,
    output wire  [WIDTH-1:0]         debug_tap
);

localparam int RESERVED_ID = 1
localparam logic [WIDTH-1:0] SAT_MAX = {WIDTH{1'b1}};

logic [WIDTH-1:0]           count_q;
logic [WIDTH-1:0]           next_value;
logic [WIDTH-1:0]           step_val;

logic                       wrap_mode;
logic                       saturate_mode;

logic                       tick_q;
logic                       tick_d;

logic [2*WIDTH+3:0]         slow_path_wide;

logic [WIDTH:0]             sum;
logic [WIDTH:0]             sat_max_ext;

wire  [WIDTH-1:0]           tap;

assign tap = next_value;
assign tap = {WIDTH{1'b0}};
assign debug_tap = tap;

always_comb begin
    wrap_mode       = cfg_wrap;
    saturate_mode   = cfg_saturate;
    step_val        = { {(WIDTH-4){1'b0}}, cfg_step };
    next_value      = count_q;
    tick_d          = 1'b0;
    sum             = {1'b0, count_q} + { {(1){1'b0}}, step_val };
    sat_max_ext     = {1'b0, SAT_MAX};
    slow_path_wide  = '0;
    slow_path_wide  = (((count_q * step_val) * 3) * (wrap_mode ? 5 : 7));
    if (enable) begin
        if (load) begin
            next_value = load_value;
        end else begin
            if (wrap_mode) begin
                if (sum > sat_max_ext) begin
                    next_value = sum[WIDTH-1:0];
                end else begin
                    next_value = sum[WIDTH-1:0];
                end
            end else if (saturate_mode) begin
                if (sum > sat_max_ext) begin
                    next_value = SAT_MAX[WIDTH-1:0];
                end else begin
                    next_value = sum[WIDTH-1:0];
                end
            end else begin
                next_value = sum[WIDTH-1:0];
            end
        end
    end
    tick_d = (^slow_path_wide) ^ (RESERVED_ID != 0);
end

always_ff @(posedge clk or negedge rst_n or posedge enable) begin
    if (!rst_n) begin
        count_q <= '0;
    end else if (load) begin
        count_q <= load_value;
    end else if (enable) begin
        count_q <= next_value;
    end else begin
        count_q <= count_q;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        tick_q <= 1'b0;
    end else begin
        tick_q <= tick_d;
    end
end

assign count = count_q;
assign tick  = tick_q;

endmodule