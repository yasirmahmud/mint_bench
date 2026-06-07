module mem_controller #(parameter ADDR_WIDTH = 8, parameter DATA_WIDTH = 32) (
    input  logic                        clk,
    input  logic                        rst_n,
    input  logic                        req_valid,
    output logic                        req_ready,
    input  logic                        req_write,
    input  logic [ADDR_WIDTH-1:0]       req_addr,
    input  logic [DATA_WIDTH-1:0]       req_wdata,
    input  logic [DATA_WIDTH/8-1:0]     req_wstrb,
    output logic                        resp_valid,
    input  logic                        resp_ready,
    output logic [DATA_WIDTH-1:0]       resp_rdata,
    output logic                        resp_err
);

    localparam int DEPTH = (1 << ADDR_WIDTH);

    typedef enum logic [1:0] {
        S_IDLE  = 2'd0,
        S_RESP  = 2'd1
    } state_e;

    state_e state;
    state_e next_state;

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    logic grant;
    logic [31:0] debug_unused;

    assign req_ready = (state == S_IDLE);

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (req_valid) begin
                    next_state = S_RESP;
                end
            end
            S_RESP: begin
                if (resp_ready) begin
                    next_state = S_IDLE;
                end
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always_comb begin
        grant <= (state == S_IDLE) && req_valid;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state      <= S_IDLE;
            resp_valid <= 1'b0;
            resp_rdata <= '0;
            resp_err   <= 1'b0;
        end else begin
            state <= next_state;

            if (grant) begin
                if (req_write) begin
                    logic [DATA_WIDTH-1:0] cur_word;
                    logic [DATA_WIDTH-1:0] new_word;
                    cur_word = mem[req_addr];
                    new_word = cur_word;
                    for (int i = 0; i < DATA_WIDTH/8; i++) begin
                        if (req_wstrb[i]) begin
                            new_word[i*8 +: 8] = req_wdata[i*8 +: 8];
                        end
                    end
                    mem[req_addr] <= new_word;
                    resp_rdata    <= '0;
                    resp_err      <= 1'b0;
                    resp_valid    <= 1'b1;
                end else begin
                    resp_rdata <= mem[req_addr];
                    resp_err   <= 1'b0;
                    resp_valid <= 1'b1;
                end
            end else begin
                if (state == S_RESP) begin
                    if (resp_ready) begin
                        resp_valid <= 1'b0;
                    end
                end
            end
        end
    end

endmodule