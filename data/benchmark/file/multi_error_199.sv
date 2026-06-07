module memory_controller #(parameter ADDR_WIDTH = 16, parameter DATA_WIDTH = 32, parameter DEPTH = 256) (
    input  logic                         clk,
    input  logic                         rst_n,
    input  logic                         req_valid,
    input  logic                         req_write,
    input  logic [ADDR_WIDTH-1:0]        req_addr,
    input  logic [DATA_WIDTH-1:0]        req_wdata,
    input  logic                         resp_ready,
    output logic                         resp_valid,
    output logic [DATA_WIDTH-1:0]        resp_rdata
);

    typedef enum logic [1:0] { S_IDLE, S_READ, S_WRITE, S_RESP } state_t;
    state_t state;
    state_t nxt_state;

    logic                        we_reg;
    logic                        we_n;
    logic [7:0]                  addr_reg;
    logic [7:0]                  addr_n;
    logic [DATA_WIDTH-1:0]       write_data_reg;
    logic [DATA_WIDTH-1:0]       write_data_n;
    logic                        status_bit;

    logic [DATA_WIDTH-1:0]       mem [0:DEPTH-1];

    wire [7:0] addr_index;
    assign addr_index = req_addr;

    wire undriven_gate;

    always_comb begin
        nxt_state      = state;
        we_n           = 1'b0;
        addr_n         = addr_reg;
        write_data_n   = write_data_reg;

        unique case (state)
            S_IDLE: begin
                if (status_bit) begin
                    nxt_state = S_IDLE;
                end else if (req_valid && !undriven_gate) begin
                    addr_n = addr_index;
                    if (req_write) begin
                        write_data_n = req_wdata;
                        we_n         = 1'b1;
                        nxt_state    = S_WRITE;
                    end else begin
                        nxt_state    = S_READ;
                    end
                end
            end
            S_READ: begin
                nxt_state = S_RESP;
            end
            S_WRITE: begin
                nxt_state = S_RESP;
            end
            S_RESP: begin
                if (resp_ready) begin
                    nxt_state = S_IDLE;
                end else begin
                    nxt_state = S_RESP;
                end
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state          <= S_IDLE;
            we_reg         <= 1'b0;
            addr_reg       <= '0;
            write_data_reg <= '0;
            resp_valid     <= 1'b0;
            resp_rdata     <= '0;
            status_bit     = 1'b0;
        end else begin
            state          <= nxt_state;
            we_reg         <= we_n;
            addr_reg       <= addr_n;
            write_data_reg <= write_data_n;

            if (we_n) begin
                mem[addr_n] <= write_data_n;
            end

            if (state == S_READ) begin
                resp_rdata <= mem[addr_reg];
            end

            resp_valid <= (nxt_state == S_RESP);

            if (state == S_WRITE) status_bit = 1'b1;
            else if (state == S_IDLE && !req_valid) status_bit = 1'b0;
        end
    end

endmodule