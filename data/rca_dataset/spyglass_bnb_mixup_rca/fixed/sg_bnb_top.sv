`include "sg_bnb_defs.sv"

module sg_bnb_top #(
    parameter int DATA_W = 32
) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic [DATA_W-1:0]  data_in,
    output logic [DATA_W-1:0]  data_out,
    output logic              signature
);
    logic [DATA_W-1:0] r0;
    logic [DATA_W-1:0] r1;
    logic [DATA_W-1:0] r2;
    logic [DATA_W-1:0] r3;
    logic [DATA_W-1:0] r4;
    logic [DATA_W-1:0] r5;
    logic [DATA_W-1:0] r6;
    logic [DATA_W-1:0] r7;
    logic [DATA_W-1:0] r8;
    logic [DATA_W-1:0] r9;
    logic [DATA_W-1:0] r10;
    logic [DATA_W-1:0] r11;
    logic [DATA_W-1:0] r12;
    logic [DATA_W-1:0] r13;
    logic [DATA_W-1:0] r14;
    logic [DATA_W-1:0] r15;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r0 <= '0;
        else `SG_BNB_ASSIGN(r0, data_in);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r1 <= '0;
        else `SG_BNB_ASSIGN(r1, r0);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r2 <= '0;
        else `SG_BNB_ASSIGN(r2, r1);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r3 <= '0;
        else `SG_BNB_ASSIGN(r3, r2);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r4 <= '0;
        else `SG_BNB_ASSIGN(r4, r3);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r5 <= '0;
        else `SG_BNB_ASSIGN(r5, r4);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r6 <= '0;
        else `SG_BNB_ASSIGN(r6, r5);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r7 <= '0;
        else `SG_BNB_ASSIGN(r7, r6);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r8 <= '0;
        else `SG_BNB_ASSIGN(r8, r7);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r9 <= '0;
        else `SG_BNB_ASSIGN(r9, r8);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r10 <= '0;
        else `SG_BNB_ASSIGN(r10, r9);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r11 <= '0;
        else `SG_BNB_ASSIGN(r11, r10);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r12 <= '0;
        else `SG_BNB_ASSIGN(r12, r11);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r13 <= '0;
        else `SG_BNB_ASSIGN(r13, r12);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r14 <= '0;
        else `SG_BNB_ASSIGN(r14, r13);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) r15 <= '0;
        else `SG_BNB_ASSIGN(r15, r14);
    end

    assign data_out = r15;
    assign signature = ^data_out;
endmodule
