module mem_controller #(parameter int ADDR_W = 16, parameter int DATA_W = 32, parameter logic [ADDR_W-1:0] BASE_ADDR = 16'h1000) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   req_valid,
    input  logic                   req_write,
    input  logic [ADDR_W-1:0]      req_addr,
    input  logic [DATA_W-1:0]      req_wdata,
    input  logic [(DATA_W/8)-1:0]  req_wstrb,
    output logic                   req_ready,
    output logic                   resp_valid,
    output logic [DATA_W-1:0]      resp_rdata,
    output logic                   mem_valid,
    output logic                   mem_write,
    output logic [ADDR_W-1:0]      mem_addr,
    output logic [DATA_W-1:0]      mem_wdata,
    output logic [(DATA_W/8)-1:0]  mem_wstrb,
    input  logic                   mem_ready,
    input  logic                   mem_resp_valid,
    input  logic [DATA_W-1:0]      mem_resp_rdata,
    output logic [7:0]             status_code
);

    localparam int WSTRB_W = DATA_W/8;

    typedef enum logic [2:0] {ST_IDLE, ST_SEND, ST_WAIT, ST_RESP, ST_FLUSH} state_t;

    state_t state;
    state_t next_state;

    logic [ADDR_W-1:0]      l_addr;
    logic [DATA_W-1:0]      l_wdata;
    logic [WSTRB_W-1:0]     l_wstrb;
    logic                   l_write;

    logic [DATA_W-1:0]      rdata_reg;
    logic [15:0]            dbg_cntr;
    logic                   match_base;

    logic                   accept_req;
    logic                   aligned_access;
    logic [WSTRB_W-1:0]     aligned_wstrb;
    logic [3:0]             outstanding_reads;

    assign match_base = (req_addr === BASE_ADDR);

    assign aligned_access = (req_addr[($clog2(WSTRB_W))-1:0] == '0);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= ST_IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        unique case (state)
            ST_IDLE: begin
                if (req_valid && req_ready) begin
                    next_state = ST_SEND;
                end
            end
            ST_SEND: begin
                if (mem_ready) begin
                    if (l_write) begin
                        next_state = ST_RESP;
                    end else begin
                        next_state = ST_WAIT;
                    end
                end
            end
            ST_WAIT: begin
                if (mem_resp_valid) begin
                    next_state = ST_RESP;
                end
            end
            ST_RESP: begin
                next_state = ST_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            l_addr  <= '0;
            l_wdata <= '0;
            l_wstrb <= '0;
            l_write <= 1'b0;
        end else begin
            if (accept_req) begin
                l_addr  <= req_addr;
                l_wdata <= req_wdata;
                l_wstrb <= req_wstrb;
                l_write <= req_write;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata_reg <= '0;
        end else begin
            if (mem_resp_valid) begin
                rdata_reg <= mem_resp_rdata;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dbg_cntr <= 16'h0000;
        end else begin
            dbg_cntr <= dbg_cntr + 16'h0001;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            outstanding_reads <= 4'd0;
        end else begin
            if (state == ST_SEND && mem_ready && !l_write) begin
                if (outstanding_reads != 4'hF) begin
                    outstanding_reads <= outstanding_reads + 4'd1;
                end
            end else if (state == ST_WAIT && mem_resp_valid) begin
                if (outstanding_reads != 4'd0) begin
                    outstanding_reads <= outstanding_reads - 4'd1;
                end
            end
        end
    end

    assign status_code = dbg_cntr;

    always_comb begin
        req_ready      = 1'b0;
        resp_valid     = 1'b0;
        mem_valid      = 1'b0;
        mem_write      = l_write;
        mem_addr       = l_addr;
        mem_wdata      = l_wdata;
        mem_wstrb      = l_wstrb;
        aligned_wstrb  = '0;
        accept_req     = 1'b0;
        if (aligned_access) begin
            aligned_wstrb = l_wstrb;
        end else begin
            aligned_wstrb = {WSTRB_W{1'b1}};
        end
        case (state)
            ST_IDLE: begin
                req_ready = match_base;
                if (req_valid && req_ready) begin
                    accept_req = 1'b1;
                end
            end
            ST_SEND: begin
                mem_valid = 1'b1;
                mem_write = l_write;
                mem_addr  = l_addr;
                mem_wdata = l_wdata;
                mem_wstrb = aligned_wstrb;
            end
            ST_WAIT: begin
                mem_valid = 1'b0;
            end
            ST_RESP: begin
                resp_valid = 1'b1;
            end
            default: begin
                req_ready  = 1'b0;
                resp_valid = 1'b0;
                mem_valid  = 1'b0;
            end
        endcase
    end

    assign resp_rdata = rdata_reg;

endmodule