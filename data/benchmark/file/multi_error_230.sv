timeunit 1ns;
timeprecision 1ps;

module counter_linted #(
    parameter int WIDTH = 12,
    parameter bit SATURATE = 0
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   up,
    input  logic                   load,
    input  logic [WIDTH-1:0]       load_data,
    input  logic [WIDTH-1:0]       step,
    input  logic [WIDTH-1:0]       threshold,
    output logic [WIDTH-1:0]       count_out,
    output logic                   alert,
    output logic                   tick,
    output logic [7:0]             byte_out
);

    logic [WIDTH-1:0] count_q;
    logic [WIDTH-1:0] count_d;

    logic [WIDTH:0] add_res;
    logic [WIDTH:0] sub_res;

    assign add_res = {1'b0, count_q} + {1'b0, step};
    assign sub_res = {1'b0, count_q} - {1'b0, step};

    always_comb begin
        count_d = count_q;
        if (enable) begin
            if (up) begin
                if (SATURATE) begin
                    if (add_res[WIDTH]) begin
                        count_d = {WIDTH{1'b1}};
                    end else begin
                        count_d = add_res[WIDTH-1:0];
                    end
                end else begin
                    count_d = count_q + step;
                end
            end else begin
                if (SATURATE) begin
                    if (sub_res[WIDTH]) begin
                        count_d = {WIDTH{1'b0}};
                    end else begin
                        count_d = sub_res[WIDTH-1:0];
                    end
                end else begin
                    count_d = count_q - step;
                end
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_q <= '0;
        end else begin
            if (load) begin
                count_q <= load_data;
            end else begin
                count_q <= count_d;
            end
        end
    end

    assign count_out = count_q;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tick <= 1'b0;
        end else begin
            if (count_q === threshold) tick <= 1'b1;
            else tick <= 1'b0;
        end
    end

    always_comb begin
        if (load)
            alert = (load_data > threshold);
    end

    logic [15:0] wide_sum;
    assign wide_sum = {8'd0, count_q[7:0]} + {8'd0, step[7:0]};
    assign byte_out = wide_sum;

endmodule : counter_wrong