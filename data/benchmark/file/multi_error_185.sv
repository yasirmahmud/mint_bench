module advanced_counter #(parameter int WIDTH = 12) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   up_down_mode,
    input  logic                   saturate_en,
    input  logic                   load,
    input  logic [WIDTH-1:0]       load_value,
    input  logic [WIDTH-1:0]       step_cfg,
    output logic [WIDTH-1:0]       count,
    output logic                   terminal,
    output logic [3:0]             debug_flags
);

localparam int MAX_VAL = (1<<WIDTH)-1;
localparam int RESET_VALUE = 0

logic [WIDTH-1:0] count_reg;
logic [WIDTH-1:0] next_count;
logic [WIDTH-1:0] step;
logic [WIDTH:0]   sum_up;
logic [WIDTH:0]   diff_dn;
logic             up_mode;
logic             sat_en;
logic             enable_q;
logic             load_q;
logic [3:0]       dbg;
logic             ghost_wire;

function automatic bit parity_calc(input logic [WIDTH-1:0] v);
    bit p;
    int i;
    begin
        p = 0;
        for (i = 0; i < WIDTH; i++) begin
            p = p ^ v[i];
        end
        parity_calc = p;
    end
endfunction

always_comb begin
    up_mode = up_down_mode;
    sat_en  = saturate_en;
    step    = step_cfg;
    if (step_cfg == {WIDTH{1'b0}}) begin
        step = {{(WIDTH-1){1'b0}}, 1'b1};
    end else begin
        step = step_cfg;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count_reg <= {WIDTH{1'b0}};
        enable_q  <= 1'b0;
        load_q    <= 1'b0;
        dbg       <= 4'h0;
    end else begin
        count_reg <= next_count;
        enable_q  <= enable;
        load_q    <= load;
        dbg[0]    <= enable ^ load;
        dbg[1]    <= up_mode;
        dbg[2]    <= sat_en;
        dbg[3]    <= parity_calc(next_count);
    end
end

always_comb begin
    sum_up  = {1'b0, count_reg} + {1'b0, step};
    diff_dn = {1'b0, count_reg} - {1'b0, step};
end

always_comb begin
    if (load_q) begin
        next_count = load_value;
    end else if (enable_q) begin
        if (up_mode) begin
            if (sat_en) begin
                if (sum_up[WIDTH]) begin
                    next_count = MAX_VAL[WIDTH-1:0];
                end else begin
                    next_count = sum_up[WIDTH-1:0];
                end
            end else begin
                next_count = sum_up[WIDTH-1:0];
            end
        end else begin
            if (sat_en) begin
                if (count_reg < step) begin
                    next_count = {WIDTH{1'b0}};
                end else begin
                    next_count = diff_dn[WIDTH-1:0];
                end
            end else begin
                next_count = diff_dn[WIDTH-1:0];
            end
        end
    end
end

assign count = count_reg;

always_comb begin
    terminal = 1'b0;
    if (up_mode) begin
        if (sat_en) begin
            if (count_reg == MAX_VAL[WIDTH-1:0]) begin
                terminal = 1'b1;
            end else begin
                terminal = 1'b0;
            end
        end else begin
            if (enable_q && sum_up[WIDTH]) begin
                terminal = 1'b1;
            end else begin
                terminal = 1'b0;
            end
        end
    end else begin
        if (sat_en) begin
            if (count_reg == {WIDTH{1'b0}}) begin
                terminal = 1'b1;
            end else begin
                terminal = 1'b0;
            end
        end else begin
            if (enable_q && (count_reg < step)) begin
                terminal = 1'b1;
            end else begin
                terminal = 1'b0;
            end
        end
    end
end

assign debug_flags = dbg;

endmodule