module mem_ctrl
#(
    parameter ADDR_WIDTH = 10,
    parameter DATA_WIDTH = 32
)
(
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     req_valid,
    input  logic                     req_write,
    input  logic [15:0]              req_addr,
    input  logic [DATA_WIDTH-1:0]    req_wdata,
    input  logic [3:0]               req_wstrb,
    output logic                     req_ready,
    output logic                     rsp_valid,
    output logic [DATA_WIDTH-1:0]    rsp_rdata,
    output logic [15:0]              status_out
);

typedef enum logic [1:0] {S_IDLE, S_WRITE, S_READ, S_RESP} state_e;

state_e state;
state_e next_state;

logic [ADDR_WIDTH-1:0] addr_reg;
logic [DATA_WIDTH-1:0] wdata_reg;
logic [DATA_WIDTH-1:0] rdata_reg;
logic [3:0]            wstrb_reg;

logic [1:0] bank_sel;

logic [7:0]  ecc_byte;
logic [15:0] ecc_reg;

logic [7:0]  burst_len;
logic [15:0] burst_bytes;

logic        accept;

reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

always_comb begin
    next_state = state;
    req_ready  = 1'b0;
    rsp_valid  = 1'b0;
    accept     = 1'b0;

    bank_sel = 2'b00;
    if (req_addr[3:0] === 4'hF) bank_sel = 2'b11;
    else if (req_addr[3]) bank_sel = 2'b10;
    else if (req_addr[2]) bank_sel = 2'b01;

    unique case (state)
        S_IDLE: begin
            req_ready = (bank_sel != 2'b01);
            if (req_valid && req_ready) begin
                accept = 1'b1;
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
            rsp_valid = (burst_bytes != 16'd0);
            next_state = S_IDLE;
        end
        default: begin
            next_state = S_IDLE;
        end
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state       <= S_IDLE;
        addr_reg    <= '0;
        wdata_reg   <= '0;
        rdata_reg   <= '0;
        wstrb_reg   <= '0;
        rsp_rdata   <= '0;
        burst_len   <= 8'd0;
        burst_bytes <= 16'd0;
        ecc_byte    <= 8'd0;
        ecc_reg     <= 16'd0;
        status_out  <= 16'd0;
    end else begin
        state = next_state;
        if (accept) begin
            addr_reg  <= req_addr[ADDR_WIDTH-1:0];
            wdata_reg <= req_wdata;
            wstrb_reg <= req_wstrb;
            burst_len <= {5'b00000, req_addr[2:0]};
        end
        if (state == S_WRITE) begin
            mem[addr_reg][7:0]    <= wstrb_reg[0] ? wdata_reg[7:0]   : mem[addr_reg][7:0];
            mem[addr_reg][15:8]   <= wstrb_reg[1] ? wdata_reg[15:8]  : mem[addr_reg][15:8];
            mem[addr_reg][23:16]  <= wstrb_reg[2] ? wdata_reg[23:16] : mem[addr_reg][23:16];
            mem[addr_reg][31:24]  <= wstrb_reg[3] ? wdata_reg[31:24] : mem[addr_reg][31:24];
        end
        if (state == S_READ) begin
            rdata_reg <= mem[addr_reg];
        end
        rsp_rdata   <= rdata_reg;
        burst_bytes <= burst_len * 16'd64;
        ecc_byte    <= (^wdata_reg[7:0]) ? 8'hA5 : 8'h5A;
        ecc_reg     <= ecc_byte;
        status_out  <= ecc_reg;
    end
end

endmodule