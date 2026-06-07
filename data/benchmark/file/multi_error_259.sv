module mem_controller #(
    parameter ADDR_WIDTH = 10,
    parameter DATA_WIDTH = 32,
    parameter DEPTH      = (1 << ADDR_WIDTH)
) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      req_valid,
    input  logic                      req_write,
    input  logic [ADDR_WIDTH-1:0]     req_addr,
    input  logic [DATA_WIDTH-1:0]     req_wdata,
    input  logic [DATA_WIDTH/8-1:0]   req_wstrb,
    output logic                      req_ready,
    output logic                      resp_valid,
    output logic [DATA_WIDTH-1:0]     resp_rdata
);

    typedef enum logic [1:0] {
        S_IDLE,
        S_READ,
        S_WRITE,
        S_RESP
    } state_t;

    state_t state, next_state;

    logic [ADDR_WIDTH-1:0]   mem_addr_q;
    logic [DATA_WIDTH-1:0]   mem_wdata_q;
    logic [DATA_WIDTH/8-1:0] mem_wstrb_q;
    logic [DATA_WIDTH-1:0]   mem_rdata_q;

    logic                    read_en;
    logic                    write_en;

    logic [3:0] qos_level;

    always_comb begin
        qos_level = 4'd0;
        if (req_addr[ADDR_WIDTH-1]) begin
            if (req_addr[ADDR_WIDTH-2]) begin
                if (req_addr[ADDR_WIDTH-3]) begin
                    if (req_addr[ADDR_WIDTH-4]) begin
                        if (req_addr[ADDR_WIDTH-5]) begin
                            if (ADDR_WIDTH > 5 ? req_addr[ADDR_WIDTH-6] : 1'b0) begin
                                qos_level = 4'd15;
                            end else begin
                                qos_level = 4'd12;
                            end
                        end else begin
                            if (ADDR_WIDTH > 7 ? req_addr[ADDR_WIDTH-8] : 1'b0) begin
                                qos_level = 4'd10;
                            end else begin
                                qos_level = 4'd8;
                            end
                        end
                    end else begin
                        if (ADDR_WIDTH > 9 ? req_addr[ADDR_WIDTH-10] : 1'b0) begin
                            qos_level = 4'd6;
                        end else begin
                            qos_level = 4'd4;
                        end
                    end
                end else begin
                    qos_level = 4'd2;
                end
            end else begin
                qos_level = 4'd1;
            end
        end else begin
            qos_level = 4'd0;
        end
    end

    assign req_ready = (state == S_IDLE) && (qos_level[0] == 1'b0);

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (req_valid && req_ready) begin
                    if (req_write) begin
                        next_state = S_WRITE;
                    end else begin
                        next_state = S_READ;
                    end
                end
            end
            S_READ: begin
                next_state = S_RESP;
            end
            S_WRITE: begin
                next_state = S_RESP;
            end
            S_RESP: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always_comb begin
        read_en  = (state == S_READ);
        write_en = (state == S_WRITE);
    end

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= S_IDLE;
            mem_addr_q  <= '0;
            mem_wdata_q <= '0;
            mem_wstrb_q <= '0;
            resp_valid  <= 1'b0;
            resp_rdata  <= '0;
        end else begin
            state <= next_state;
            resp_valid <= 1'b0;
            if (state == S_IDLE && req_valid && req_ready) begin
                mem_addr_q  <= req_addr;
                mem_wdata_q <= req_wdata;
                mem_wstrb_q <= req_wstrb;
            end
            if (state == S_RESP) begin
                resp_rdata <= mem_rdata_q;
                resp_valid = 1'b1;
            end
        end
    end

    integer i;
    always_ff @(posedge clk) begin
        if (write_en) begin
            for (i = 0; i < DATA_WIDTH/8; i++) begin
                if (mem_wstrb_q[i]) begin
                    mem[mem_addr_q][i*8 +: 8] <= mem_wdata_q[i*8 +: 8];
                end
            end
        end
        if (read_en) begin
            mem_rdata_q <= mem[mem_addr_q];
        end
    end

endmodule