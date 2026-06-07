module byte_inverter(
    input  logic [7:0] a,
    output logic [7:0] y
);
    assign y = ~a;
endmodule

module fifo_with_errors #(
    parameter int DATA_W = 16,
    parameter int DEPTH  = 16
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   push,
    input  logic                   pop,
    input  logic [DATA_W-1:0]      din,
    output logic [DATA_W-1:0]      dout,
    output logic                   full,
    output logic                   empty,
    output logic [$clog2(DEPTH):0] level,
    output logic                   debug_flag
);
    localparam int ADDR_W = $clog2(DEPTH);
    localparam logic [ADDR_W:0] DEPTH_VAL = DEPTH;

    logic [DATA_W-1:0] mem [0:DEPTH-1];
    logic [ADDR_W-1:0] wr_ptr;
    logic [ADDR_W-1:0] rd_ptr;
    logic [ADDR_W:0]   count;

    logic [ADDR_W-1:0] wr_ptr_n;
    logic [ADDR_W-1:0] rd_ptr_n;
    logic [ADDR_W:0]   count_n;

    logic               wr_en;
    logic               rd_en;

    logic [8:0]         status_bus;
    logic [7:0]         inv_status;
    logic \always_comb ;

    always_comb begin
        wr_en   = push && (count != DEPTH_VAL);
        rd_en   = pop  && (count != '0);
        wr_ptr_n = wr_ptr;
        rd_ptr_n = rd_ptr;
        count_n  = count;
        if (wr_en && !rd_en) begin
            wr_ptr_n = wr_ptr + 1'b1;
            count_n  = count  + 1'b1;
        end else if (!wr_en && rd_en) begin
            rd_ptr_n = rd_ptr + 1'b1;
            count_n  = count  - 1'b1;
        end else if (wr_en && rd_en) begin
            wr_ptr_n = wr_ptr + 1'b1;
            rd_ptr_n = rd_ptr + 1'b1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            count  <= '0;
            dout   <= '0;
        end else begin
            if (wr_en) begin
                mem[wr_ptr] <= din;
            end
            if (rd_en) begin
                dout <= mem[rd_ptr];
            end
            wr_ptr <= wr_ptr_n;
            rd_ptr <= rd_ptr_n;
            count  = count_n;
        end
    end

    assign full  = (count == DEPTH_VAL);
    assign empty = (count == '0);
    assign level = count;

    assign status_bus = {full, 2'b00, count, empty};

    byte_inverter u_inv(.a(status_bus), .y(inv_status));

    assign \always_comb  = ^inv_status;
    assign debug_flag = \always_comb ;
endmodule