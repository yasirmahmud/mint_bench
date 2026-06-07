module mem_controller (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        req,
    input  logic        write_en,
    input  logic [15:0] addr,
    input  logic [31:0] wdata,
    output logic [31:0] rdata,
    output logic        ready,
    output logic        rvalid
);

    parameter int DEPTH = 256;

    typedef enum logic [1:0] {
        IDLE  = 2'd0,
        READ  = 2'd1,
        WRITE = 2'd2,
        RESP  = 2'd3
    } state_t;

    state_t state;
    state_t next_state;

    logic [31:0] mem [0:DEPTH-1];

    logic [7:0]  addr_r;
    logic [31:0] wdata_r;

    logic ready_next;
    logic rvalid_next;

    always @(state or req or write_en) begin
        next_state  = state;
        ready_next  = 1'b0;
        rvalid_next = 1'b0;

        unique case (state)
            IDLE: begin
                ready_next = 1'b1;
                if (req) begin
                    if (write_en) begin
                        next_state = WRITE;
                    end else begin
                        next_state = READ;
                    end
                end
            end
            READ: begin
                next_state = RESP;
            end
            WRITE: begin
                next_state = RESP;
            end
            RESP: begin
                rvalid_next = 1'b1;
                if (!req) begin
                    next_state = IDLE;
                end
            end
        endcase

        if (!write_en && req && addr[0]) begin
            rvalid_next = 1'b1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= IDLE;
            ready   <= 1'b1;
            rvalid  <= 1'b0;
            rdata   <= 32'h0000_0000;
            addr_r  <= 8'h00;
            wdata_r <= 32'h0000_0000;
        end else begin
            state  <= next_state;
            ready  <= ready_next;
            rvalid <= rvalid_next;

            if (state == IDLE && req) begin
                addr_r <= addr;
                if (write_en) begin
                    wdata_r <= wdata;
                end
            end

            if (state == WRITE) begin
                mem[addr_r] <= wdata_r;
            end

            if (state == READ) begin
                rdata = mem[addr_r];
            end
        end
    end

endmodule