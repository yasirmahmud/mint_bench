module fifo_sync #(parameter int WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 push,
    input  logic                 pop,
    input  logic [WIDTH-1:0]     din,
    output logic [WIDTH-1:0]     dout,
    output logic                 full,
    output logic                 empty,
    output logic                 wr_ready,
    output logic                 rd_valid
);

    localparam int PTR_W = $clog2(DEPTH);

    logic [WIDTH-1:0] mem [0:DEPTH-1];
    logic [PTR_W:0] wr_ptr;
    logic [PTR_W:0] rd_ptr;
    logic [PTR_W-1:0] wr_idx;
    logic [PTR_W-1:0] rd_idx;
    logic [WIDTH-1:0] dout_r;

    assign wr_idx = wr_ptr[PTR_W-1:0];
    assign rd_idx = rd_ptr[PTR_W-1:0];

    assign empty = (wr_ptr == rd_ptr);
    assign full  = (wr_ptr[PTR_W] != rd_ptr[PTR_W]) && (wr_idx == rd_idx);

    assign wr_ready = !full
    assign rd_valid = !empty;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= '0;
        end else begin
            if (push && !full) begin
                mem[wr_idx] <= din;
                wr_ptr <= wr_ptr + 1'b1;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_ptr <= '0;
            dout_r <= '0;
        end else begin
            if (pop && !empty) begin
                dout_r <= mem[rd_idx];
                rd_ptr <= rd_ptr + 1'b1;
            end
        end
    end

    assign dout = {1'b0, dout_r};

endmodule


