`include "sg_bnbn_defs.sv"

module sg_bnbn_pipe #(
    parameter int DATA_W = 8
) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic [DATA_W-1:0]  in_data,
    output logic [DATA_W-1:0]  out_data,
    output logic [DATA_W-1:0]  tap2
);
    logic [DATA_W-1:0] p0;
    logic [DATA_W-1:0] p1;
    logic [DATA_W-1:0] p2;
    logic [DATA_W-1:0] p3;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) p0 <= '0;
        else `SG_BNBN_ASSIGN(p0, in_data);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) p1 <= '0;
        else `SG_BNBN_ASSIGN(p1, p0);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) p2 <= '0;
        else `SG_BNBN_ASSIGN(p2, p1);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) p3 <= '0;
        else `SG_BNBN_ASSIGN(p3, p2);
    end

    assign out_data = p3;
    assign tap2 = p2;
endmodule
