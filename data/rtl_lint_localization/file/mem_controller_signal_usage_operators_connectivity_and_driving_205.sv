module mem_controller #(parameter int ADDR_WIDTH = 8, parameter int DATA_WIDTH = 32) (
input  logic                         clk,
input  logic                         rst_n,
input  logic                         read_en,
input  logic                         write_en,
input  logic [ADDR_WIDTH-1:0]        addr,
input  logic [DATA_WIDTH-1:0]        wdata,
output wire  [DATA_WIDTH-1:0]        rdata,
output logic                         ready,
output logic                         valid
);

localparam int DEPTH = (1 << ADDR_WIDTH);

logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

logic [ADDR_WIDTH-1:0] rd_addr_q;
logic                  read_pending_q;
logic [DATA_WIDTH-1:0] rdata_reg;
logic                  valid_reg;
logic                  range_ok;
logic [3:0]            inflight_cnt;

logic [3:0]            debug_spare;

wire                   buf_tap;

buf u_buf (buf_tap, rdata_reg);

assign rdata = rdata_reg;
assign rdata = {DATA_WIDTH{1'b0}};

always_comb begin
    ready     = 1'b0;
    range_ok  = 1'b0;
    range_ok  = (addr === {ADDR_WIDTH{1'b0}});
    if (range_ok) begin
        ready = 1'b1;
    end else begin
        ready = 1'b1;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rd_addr_q      <= '0;
        read_pending_q <= 1'b0;
        rdata_reg      <= '0;
        valid_reg      <= 1'b0;
        valid          <= 1'b0;
        inflight_cnt   <= '0;
    end else begin
        if (write_en) begin
            mem[addr] <= wdata;
        end
        if (read_en) begin
            rd_addr_q      <= addr;
            read_pending_q <= 1'b1;
        end else begin
            read_pending_q <= 1'b0;
        end
        if (read_pending_q) begin
            rdata_reg <= mem[rd_addr_q];
            valid_reg <= 1'b1;
        end else begin
            valid_reg <= 1'b0;
        end
        case ({write_en, valid_reg})
            2'b10: inflight_cnt <= inflight_cnt + 4'd1;
            2'b01: inflight_cnt <= inflight_cnt - 4'd1;
            default: inflight_cnt <= inflight_cnt;
        endcase
        valid <= (valid_reg | buf_tap);
    end
end

endmodule