`timescale 1ns/1ps
`default_nettype none

module cpu1_regfile (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        write_en,
    input  wire [2:0]  raddr1,
    input  wire [2:0]  raddr2,
    input  wire [2:0]  waddr,
    input  wire [31:0] wdata,
    output reg  [31:0] rdata1,
    output reg  [31:0] rdata2
);
    reg [31:0] r1_q;
    reg [31:0] r2_q;
    reg [31:0] r3_q;
    reg [31:0] r4_q;
    reg [31:0] r5_q;
    reg [31:0] r6_q;
    reg [31:0] r7_q;

    always @* begin
        case (raddr1)
            3'd0: rdata1 = 32'd0;
            3'd1: rdata1 = r1_q;
            3'd2: rdata1 = r2_q;
            3'd3: rdata1 = r3_q;
            3'd4: rdata1 = r4_q;
            3'd5: rdata1 = r5_q;
            3'd6: rdata1 = r6_q;
            default: rdata1 = r7_q;
        endcase
    end

    always @* begin
        case (raddr2)
            3'd0: rdata2 = 32'd0;
            3'd1: rdata2 = r1_q;
            3'd2: rdata2 = r2_q;
            3'd3: rdata2 = r3_q;
            3'd4: rdata2 = r4_q;
            3'd5: rdata2 = r5_q;
            3'd6: rdata2 = r6_q;
            default: rdata2 = r7_q;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r1_q <= 32'd0;
            r2_q <= 32'd0;
            r3_q <= 32'd0;
            r4_q <= 32'd0;
            r5_q <= 32'd0;
            r6_q <= 32'd0;
            r7_q <= 32'd0;
        end else if (write_en) begin
            case (waddr)
                3'd1: r1_q <= wdata;
                3'd2: r2_q <= wdata;
                3'd3: r3_q <= wdata;
                3'd4: r4_q <= wdata;
                3'd5: r5_q <= wdata;
                3'd6: r6_q <= wdata;
                3'd7: r7_q <= wdata;
                default: begin
                    r1_q <= r1_q;
                end
            endcase
        end
    end
endmodule

`default_nettype wire
