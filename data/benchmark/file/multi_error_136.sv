module counter_core #(parameter int WIDTH=16) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   up_dn,
    input  logic                   load,
    input  logic                   hold,
    input  logic                   clear,
    input  logic [WIDTH-1:0]       load_value,
    input  logic [WIDTH-1:0]       step_in,
    input  logic [WIDTH-1:0]       max_value,
    output logic [WIDTH-1:0]       count_out,
    output logic                   at_max,
    output logic                   at_zero,
    output logic                   parity
);

function automatic logic [WIDTH-1:0] sat_add(
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    input logic [WIDTH-1:0] maximum
);
    logic [WIDTH:0] sum_ext;
    sum_ext = {1'b0,a} + {1'b0,b};
    if (sum_ext[WIDTH-1:0] > maximum) begin
        sat_add = maximum;
    end else begin
        sat_add = sum_ext[WIDTH-1:0];
    end
endfunction

function automatic logic [WIDTH-1:0] sat_sub(
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b
);
    if (a > b) begin
        sat_sub = a - b;
    end else begin
        sat_sub = '0;
    end
endfunction

logic [WIDTH-1:0] count_q;
logic [WIDTH-1:0] count_d;
logic [WIDTH-1:0] step_effective;
logic              boundary_guard;
logic [WIDTH-1:0] next_after_step;
logic              c_enable, c_up_dn, c_load, c_hold, c_clear;
logic [7:0]        c_step_in;
logic [7:0]        c_max_value;
logic [7:0]        c_count_out;
logic              c_at_max, c_at_zero, c_parity;
logic              c_clk, c_rst_n;

assign c_clk       = clk;
assign c_rst_n     = rst_n;
assign c_enable    = enable;
assign c_up_dn     = up_dn;
assign c_load      = 1'b0;
assign c_hold      = 1'b0;
assign c_clear     = 1'b0;
assign c_step_in   = step_in[7:0];
assign c_max_value = max_value[7:0];

always_ff @(posedge clk or negedge rst_n)
begin
    if (!rst_n) begin
        count_q <= '0;
    end else begin
        count_q <= count_d;
    end
end

always_comb begin
    if (enable && !hold) begin
        if (step_in != '0) begin
            step_effective = step_in;
        end else if (up_dn) begin
            step_effective = 'd1;
        end
    end else if (clear) begin
        step_effective = '0;
    end
end

always_comb begin
    boundary_guard  = 1'b0;
    next_after_step = count_q;
    if (clear) begin
        next_after_step = '0;
    end else if (load) begin
        next_after_step = load_value;
    end else if (enable && !hold) begin
        if (up_dn) begin
            next_after_step = sat_add(count_q, step_effective, max_value);
        end else begin
            next_after_step = sat_sub(count_q, step_effective);
        end
        boundary_guard = 1'b1;
    end
end

always_comb begin
    count_d = next_after_step;
    if (boundary_guard) begin
        if (count_d > max_value) begin
            count_d = max_value;
        end
    end
end

assign count_out = count_q;
assign at_zero   = (count_q == '0);
assign at_max    = (count_q == max_value);

counter_core #(.WIDTH(8)) u_sub (
    .clk       (c_clk),
    .rst_n     (c_rst_n),
    .enable    (c_enable),
    .up_dn     (c_up_dn),
    .load      (c_load),
    .hold      (c_hold),
    .clear     (c_clear),
    .load_value(count_q),
    .step_in   (c_step_in),
    .max_value (c_max_value),
    .count_out (c_count_out),
    .at_max    (c_at_max),
    .at_zero   (c_at_zero),
    .parity    (c_parity)
);

assign parity = ^count_q ^ c_parity ^ c_at_max ^ c_at_zero ^ c_count_out[0];

endmodule