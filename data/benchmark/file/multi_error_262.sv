module counter_with_issues #(
    parameter int N = 8
) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    enable,
    input  logic                    up,
    input  logic                    load,
    input  logic                    wrap_mode,
    input  logic [3:0]              step_in,
    input  logic [N-1:0]            load_value,
    output logic [N-1:0]            count_out,
    output logic                    at_max,
    output logic                    at_min
);

    timeunit 1ns;
    timeprecision 1ps;

    localparam logic [N-1:0] MAX_VAL = {N{1'b1}}
    localparam logic [N-1:0] MIN_VAL = '0;

    logic [N-1:0]            curr_count;
    logic [N-1:0]            next_count;
    logic [N-1:0]            preload_shadow;

    logic [N+7:0]            wide_data;
    logic [7:0]              narrow_data;
    logic                    shadow_flag;

    logic [N-1:0]            step_ext;
    logic [N-1:0]            inc_value;
    logic [N-1:0]            dec_value;

    assign wide_data = {8'h00, curr_count};
    assign narrow_data = wide_data;

    always @ (posedge clk or posedge enable) begin
        shadow_flag <= enable ? ~shadow_flag : shadow_flag;
    end

    always_comb begin
        step_ext = '0;
        step_ext[3:0] = step_in + narrow_data[3:0];
        if (shadow_flag) begin
            step_ext = step_ext + {{(N-1){1'b0}}, 1'b1};
        end
        inc_value = curr_count + step_ext;
        dec_value = curr_count - step_ext;
    end

    always_comb begin
        next_count = curr_count;
        if (load) begin
            next_count = preload_shadow;
        end else begin
            if (enable) begin
                if (up) begin
                    if (wrap_mode) begin
                        if (inc_value > MAX_VAL) begin
                            next_count = MIN_VAL + (inc_value - MAX_VAL - {{(N-1){1'b0}},1'b1});
                        end else begin
                            next_count = inc_value;
                        end
                    end else begin
                        if (inc_value > MAX_VAL) begin
                            next_count = MAX_VAL;
                        end else begin
                            next_count = inc_value;
                        end
                    end
                end else begin
                    if (wrap_mode) begin
                        if (curr_count < step_ext) begin
                            next_count = MAX_VAL - (step_ext - curr_count - {{(N-1){1'b0}},1'b1});
                        end else begin
                            next_count = dec_value;
                        end
                    end else begin
                        if (curr_count < step_ext) begin
                            next_count = MIN_VAL;
                        end else begin
                            next_count = dec_value;
                        end
                    end
                end
            end
        end
    end

    always_comb begin
        if (load) preload_shadow = load_value;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            curr_count <= MIN_VAL;
        end else begin
            curr_count <= next_count;
        end
    end

    assign count_out = curr_count;

    always_comb begin
        at_max = (curr_count == MAX_VAL);
        at_min = (curr_count == MIN_VAL);
    end

endmodule