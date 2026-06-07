`timescale 1ns/1ps
`default_nettype none

module cpu1_csr (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        irq,
    input  wire        trap_req,
    input  wire        retire,
    input  wire [15:0] pc,
    input  wire [31:0] instr,
    input  wire        write_en,
    input  wire [2:0]  csr_addr,
    input  wire [31:0] write_data,
    output wire        irq_pending,
    output reg  [31:0] read_data,
    output wire [15:0] trap_vector,
    output wire [31:0] status_word
);
    reg [31:0] status_q;
    reg [31:0] epc_q;
    reg [31:0] cause_q;
    reg [31:0] status_d;
    reg [31:0] epc_d;
    reg [31:0] cause_d;

    assign irq_pending = irq & status_q[0];
    assign trap_vector = 16'h0100 + {12'd0, cause_q[3:0]};
    assign status_word = status_q ^ epc_q ^ cause_q;

    always @* begin
        case (csr_addr)
            3'd0: read_data = status_q;
            3'd1: read_data = epc_q;
            3'd2: read_data = cause_q;
            3'd3: read_data = {16'd0, trap_vector};
            default: read_data = status_word;
        endcase
    end

    always @* begin
        status_d = status_q;
        epc_d = epc_q;
        cause_d = cause_q;

        if (trap_req) begin
            status_d = {status_q[31:2], 1'b1, status_q[0]};
            epc_d = {16'd0, pc};
            if (irq) begin
                cause_d = 32'h00000010;
            end else begin
                cause_d = {24'd0, instr[31:28], instr[2:0], 1'b1};
            end
        end else if (write_en) begin
            case (csr_addr)
                3'd0: status_d = write_data;
                3'd1: epc_d = write_data;
                3'd2: cause_d = write_data;
                default: status_d = {status_q[31:2], write_data[1:0]};
            endcase
        end else if (retire) begin
            status_d = {status_q[31:2], 1'b0, status_q[0]};
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            status_q <= 32'h00000001;
            epc_q    <= 32'd0;
            cause_q  <= 32'd0;
        end else begin
            status_q <= status_d;
            epc_q <= epc_d;
            cause_q <= cause_d;
            if (retire) begin
                status_q[0] <= status_q[0];
            end
        end
    end
endmodule

`default_nettype wire
