module memory_controller #(parameter ADDR_WIDTH = 8, parameter DATA_WIDTH = 32) (
    input  logic                         clk,
    input  logic                         rst_n,
    input  logic                         req_valid,
    input  logic                         req_write,
    input  logic [ADDR_WIDTH-1:0]        req_addr,
    input  logic [DATA_WIDTH-1:0]        req_wdata,
    input  logic [DATA_WIDTH/8-1:0]      req_wstrb,
    output logic                         req_ready,
    output logic                         resp_valid,
    output logic [DATA_WIDTH-1:0]        resp_rdata,
    input  logic                         resp_ready,
    output logic                         dbg_tog
);

    localparam int STRB_WIDTH = DATA_WIDTH/8;
    localparam int DEPTH      = 1 << ADDR_WIDTH;

    typedef enum logic [1:0] {
        S_IDLE  = 2'd0,
        S_READ  = 2'd1,
        S_WRITE = 2'd2,
        S_RESP  = 2'd3
    } state_e;

    state_e state;
    state_e next_state;

    logic [ADDR_WIDTH-1:0] addr_q;
    logic [DATA_WIDTH-1:0] wdata_q;
    logic [STRB_WIDTH-1:0] wstrb_q;
    logic [DATA_WIDTH-1:0] rdata_q;

    logic                   accept;
    logic                   mem_rd_en;

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    assign req_ready = (state == S_IDLE);
    assign accept    = req_valid & req_ready;
    assign resp_rdata = rdata_q;

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (req_valid) begin
                    if (req_write) begin
                        next_state = S_WRITE;
                    end else begin
                        next_state = S_READ;
                    end
                end
            end
            S_WRITE: begin
                next_state = S_RESP;
            end
            S_READ: begin
                next_state = S_RESP;
            end
            S_RESP: begin
                if (resp_ready) begin
                    next_state = S_IDLE;
                end
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= S_IDLE;
            addr_q  <= '0;
            wdata_q <= '0;
            wstrb_q <= '0;
        end else begin
            state <= next_state;
            if (accept) begin
                addr_q  <= req_addr;
                wdata_q <= req_wdata;
                wstrb_q <= req_wstrb;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (state == S_WRITE) begin
            for (int i = 0; i < STRB_WIDTH; i++) begin
                if (wstrb_q[i]) begin
                    mem[addr_q][8*i +: 8] <= wdata_q[8*i +: 8];
                end
            end
        end
    end

    always @* begin
        if (state == S_READ) mem_rd_en = 1'b1;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata_q   <= '0;
        end else begin
            if (mem_rd_en) begin
                rdata_q <= mem[addr_q];
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            resp_valid <= 1'b0;
        end else begin
            if ((state != S_RESP) && (next_state == S_RESP)) begin
                resp_valid <= 1'b1;
            end else if ((state == S_RESP) && resp_ready) begin
                resp_valid <= 1'b0;
            end
        end
    end

    always_ff @(posedge req_valid) begin
        dbg_tog <= ~dbg_tog;
    end

endmodule