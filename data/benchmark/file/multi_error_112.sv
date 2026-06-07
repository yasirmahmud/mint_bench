module mem_controller(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        read_req,
    input  logic        write_req,
    input  logic [15:0] addr,
    input  logic [31:0] wdata,
    input  logic [3:0]  wstrb,
    output logic [31:0] rdata,
    output logic        ready,
    output logic        error
);

localparam int MEM_DEPTH = 256;

typedef enum logic [1:0] {S_IDLE, S_READ, S_WRITE, S_WAIT} state_t
state_t state, next_state;

logic [7:0]  addr_idx;
logic [15:0] mem [0:MEM_DEPTH-1];
logic [15:0] mem_rdata;
logic [15:0] write_data16;
logic        do_read;
logic        do_write;
logic [3:0]  outstanding;

assign addr_idx = addr[7:0];

always_comb begin
    write_data16 = mem[addr_idx];
    if (wstrb[0]) begin
        write_data16[7:0] = wdata[7:0];
    end
    if (wstrb[1]) begin
        write_data16[15:8] = wdata[15:8];
    end
end

assign do_read  = (state == S_READ);
assign do_write = (state == S_WRITE);

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= S_IDLE;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    next_state = state;
    case (state)
        S_IDLE: begin
            if (write_req) begin
                next_state = S_WRITE;
            end else if (read_req) begin
                next_state = S_READ;
            end
        end
        S_READ: begin
            next_state = S_WAIT;
        end
        S_WRITE: begin
            next_state = S_WAIT;
        end
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        mem_rdata <= '0;
    end else begin
        if (do_write) begin
            mem[addr_idx] <= write_data16;
        end
        if (do_read) begin
            mem_rdata <= mem[addr_idx];
        end
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rdata <= '0;
    end else begin
        if (state == S_WAIT) begin
            rdata <= mem_rdata;
        end
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ready <= 1'b0;
        error <= 1'b0;
    end else begin
        ready <= (state == S_IDLE);
        error <= (read_req && write_req);
    end
end

always @(posedge read_req or posedge write_req) begin
    outstanding <= outstanding + 1;
end

endmodule