module sg_xnp_datapath #(
    parameter int DATA_W = 8,
    parameter int DEPTH  = 8,
    parameter int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH),
    parameter logic [31:0] RESET_SEED = '0
) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic [DATA_W-1:0]  mem_rdata,
    input  logic [ADDR_W-1:0]  addr,
    input  logic [      1:0]   op_sel,
    input  logic              use_alt,
    input  logic [      3:0]   shift_amt,
    output logic [DATA_W-1:0]  out
);
    logic [DATA_W-1:0] addr_ext;
    logic [DATA_W-1:0] op_result;
    logic [DATA_W-1:0] out_next;

    always_comb begin
        addr_ext = addr;

        unique case (op_sel)
            2'd0: op_result = mem_rdata + addr_ext;
            2'd1: op_result = mem_rdata - addr_ext;
            2'd2: op_result = mem_rdata ^ addr_ext;
            default: op_result = mem_rdata;
        endcase

        out_next = (op_result << shift_amt);
        if (use_alt) begin
            out_next = out_next + DATA_W'(1);
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out <= RESET_SEED[DATA_W-1:0];
        end else begin
            out <= out_next;
        end
    end
endmodule

