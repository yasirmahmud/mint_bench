`include "sg_bnbn_defs.sv"

module sg_bnbn_datapath #(
    parameter int DATA_W = 8
) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic [DATA_W-1:0]  data_in,
    input  logic [      1:0]  op_sel,
    input  logic              use_alt,
    input  logic [      3:0]  shift_amt,
    input  logic [DATA_W-1:0]  ctrl_sum,
    output logic [DATA_W-1:0]  data_out,
    output logic [DATA_W-1:0]  status
);
    logic [DATA_W-1:0] a_r;
    logic [DATA_W-1:0] b_r;
    logic [DATA_W-1:0] y_r;
    logic [DATA_W-1:0] status_r;

    logic [DATA_W-1:0] b_next;
    logic [DATA_W-1:0] alu_next;
    logic [DATA_W-1:0] status_next;

    assign b_next = use_alt ? (data_in ^ {DATA_W{1'b1}}) : data_in;

    always_comb begin
        alu_next = '0;
        case (op_sel)
            2'd0: alu_next = a_r + b_r;
            2'd1: alu_next = a_r ^ b_r;
            2'd2: alu_next = a_r << shift_amt;
            default: alu_next = a_r - b_r;
        endcase

        status_next = alu_next ^ ctrl_sum;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) a_r <= '0;
        else `SG_BNBN_ASSIGN(a_r, data_in);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) b_r <= '0;
        else `SG_BNBN_ASSIGN(b_r, b_next);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) y_r <= '0;
        else `SG_BNBN_ASSIGN(y_r, alu_next);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) status_r <= '0;
        else `SG_BNBN_ASSIGN(status_r, status_next);
    end

    assign data_out = y_r;
    assign status = status_r;
endmodule
