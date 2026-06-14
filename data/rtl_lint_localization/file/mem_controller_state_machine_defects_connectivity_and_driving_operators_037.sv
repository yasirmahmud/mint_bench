module mem_controller #(parameter ADDR_WIDTH = 8, parameter DATA_WIDTH = 32, parameter DEPTH = 256) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  cmd_valid,
    input  logic                  cmd_write,
    input  logic [ADDR_WIDTH-1:0] cmd_addr,
    input  logic [DATA_WIDTH-1:0] cmd_wdata,
    output logic                  cmd_ready,
    output logic                  rsp_valid,
    output logic [DATA_WIDTH-1:0] rsp_rdata
);

    typedef enum logic [2:0] {S_IDLE, S_READ, S_WRITE, S_RESP, S_UNUSED} state_e;
    state_e state, next;

    logic [ADDR_WIDTH-1:0] addr_reg;
    logic [DATA_WIDTH-1:0] wdata_reg;
    logic [DATA_WIDTH-1:0] rdata_reg;
    logic                   special_zero_addr;

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    wire arb_line;
    assign arb_line = cmd_valid;
    assign arb_line = (state == S_IDLE);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state    <= S_IDLE;
            addr_reg <= '0;
            wdata_reg<= '0;
            rdata_reg<= '0;
        end else begin
            state <= next;
            if (state == S_IDLE && cmd_valid && cmd_ready) begin
                addr_reg  <= cmd_addr;
                wdata_reg <= cmd_wdata;
            end
            if (state == S_READ) begin
                rdata_reg <= mem[addr_reg];
            end
            if (state == S_WRITE) begin
                mem[addr_reg] <= wdata_reg;
            end
        end
    end

    always_comb begin
        special_zero_addr = 1'b0;
        if (cmd_addr === '0) special_zero_addr = 1'b1;
    end

    always_comb begin
        next = state;
        unique case (state)
            S_IDLE: begin
                if (cmd_valid && cmd_write) begin
                    next = S_WRITE;
                end else if (cmd_valid && !cmd_write) begin
                    next = S_READ;
                end
            end
            S_READ: begin
                next = S_RESP;
            end
            S_WRITE: begin
                next = S_RESP;
            end
            S_RESP: begin
                if (!cmd_valid || special_zero_addr) begin
                    next = S_IDLE;
                end
            end
            default: begin
                next = S_IDLE;
            end
        endcase
    end

    always_comb begin
        cmd_ready = (state == S_IDLE) && arb_line;
        rsp_valid = (state == S_RESP);
        rsp_rdata = rdata_reg;
    end

endmodule