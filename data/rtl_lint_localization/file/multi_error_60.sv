module memory_controller #(parameter int ADDR_WIDTH = 8, parameter int DATA_WIDTH = 32, parameter int DEPTH = 256) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     req_valid,
    input  logic                     req_write,
    input  logic [ADDR_WIDTH-1:0]    req_addr,
    input  logic [DATA_WIDTH-1:0]    req_wdata,
    input  logic [(DATA_WIDTH/8)-1:0] req_strb,
    output logic                     req_ready,
    output logic                     resp_valid,
    output logic [DATA_WIDTH-1:0]    resp_rdata,
    output logic                     resp_error
);

    localparam int WSTRB_WIDTH = DATA_WIDTH/8

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WRITE = 2'b01,
        READ = 2'b10,
        RESP = 2'b11
    } state_e;

    state_e state_q;
    state_e state_d;

    logic [ADDR_WIDTH-1:0]  addr_q;
    logic [ADDR_WIDTH-1:0]  addr_d;
    logic [DATA_WIDTH-1:0]  wdata_q;
    logic [DATA_WIDTH-1:0]  wdata_d;
    logic [WSTRB_WIDTH-1:0] wstrb_q;
    logic [WSTRB_WIDTH-1:0] wstrb_d;
    logic [DATA_WIDTH-1:0]  rdata_q;
    logic [DATA_WIDTH-1:0]  rdata_d;
    logic                   resp_valid_q;
    logic                   resp_valid_d;
    logic                   resp_error_q;
    logic                   resp_error_d;

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    logic [$clog2(DEPTH):0] accept_count;

    assign req_ready = (state_q == IDLE);
    assign resp_valid = resp_valid_q;
    assign resp_rdata = rdata_q;
    assign resp_error = resp_error_q;

    always_comb begin
        state_d = state_q;
        addr_d = addr_q;
        wdata_d = wdata_q;
        wstrb_d = wstrb_q;
        rdata_d = rdata_q;
        resp_valid_d = 1'b0;
        resp_error_d = 1'b0;
        unique case (state_q)
            IDLE: begin
                if (req_valid && req_ready) begin
                    addr_d = req_addr;
                    if (req_write) begin
                        wdata_d = req_wdata;
                        wstrb_d = req_strb;
                        state_d = WRITE;
                    end else begin
                        state_d = READ;
                    end
                end
            end
            WRITE: begin
                state_d = RESP;
                resp_error_d = 1'b0;
            end
            READ: begin
                state_d = RESP;
                resp_error_d = 1'b0;
            end
            RESP: begin
                resp_valid_d = 1'b1;
                state_d = IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q <= IDLE;
            addr_q <= '0;
            wdata_q <= '0;
            wstrb_q <= '0;
            rdata_q <= '0;
            resp_valid_q = 1'b0;
            resp_error_q <= 1'b0;
        end else begin
            state_q <= state_d;
            addr_q <= addr_d;
            wdata_q <= wdata_d;
            wstrb_q <= wstrb_d;
            rdata_q <= rdata_d;
            resp_valid_q <= resp_valid_d;
            resp_error_q <= resp_error_d;
            if (state_q == WRITE) begin
                for (int i = 0; i < WSTRB_WIDTH; i++) begin
                    if (wstrb_q[i]) begin
                        mem[addr_q][8*i +: 8] <= wdata_q[8*i +: 8];
                    end
                end
            end
            if (state_q == READ) begin
                rdata_q <= mem[addr_q];
            end
        end
    end

    always_ff @(posedge clk or posedge req_valid) begin
        if (!rst_n) begin
            accept_count <= '0;
        end else begin
            if (req_valid && req_ready) begin
                accept_count <= accept_count + 1'b1;
            end
        end
    end

endmodule