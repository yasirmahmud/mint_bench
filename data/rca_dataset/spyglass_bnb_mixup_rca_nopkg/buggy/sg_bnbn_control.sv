`include "sg_bnbn_defs.sv"

module sg_bnbn_control #(
    parameter int DATA_W = 8
) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic              enable,
    input  logic [DATA_W-1:0]  data_in,
    output logic [      1:0]  op_sel,
    output logic              use_alt,
    output logic [      3:0]  shift_amt,
    output logic [DATA_W-1:0]  ctrl_sum
);
    logic [      1:0] op_sel_r;
    logic             use_alt_r;
    logic [      3:0] shift_amt_r;
    logic [DATA_W-1:0] sum_r;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) op_sel_r <= 2'd0;
        else `SG_BNBN_ASSIGN(op_sel_r, op_sel_r + (enable ? 2'd1 : 2'd0));
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) use_alt_r <= 1'b0;
        else `SG_BNBN_ASSIGN(use_alt_r, enable ? ~use_alt_r : use_alt_r);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) shift_amt_r <= 4'd0;
        else `SG_BNBN_ASSIGN(shift_amt_r, shift_amt_r + (enable ? 4'd1 : 4'd0));
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) sum_r <= '0;
        else `SG_BNBN_ASSIGN(sum_r, sum_r + (enable ? data_in : {DATA_W{1'b0}}));
    end

    assign op_sel = op_sel_r;
    assign use_alt = use_alt_r;
    assign shift_amt = shift_amt_r;
    assign ctrl_sum = sum_r;
endmodule
