module sram_bank #(parameter ADDR_W = 16, parameter DATA_W = 32) (
    input  logic                   clk,
    input  logic                   en,
    input  logic                   we,
    input  logic [ADDR_W-1:0]      addr,
    input  logic [DATA_W-1:0]      din,
    output logic [DATA_W-1:0]      dout
);
    logic [DATA_W-1:0] mem [0:(1<<ADDR_W)-1];
    always_ff @(posedge clk) begin
        if (en) begin
            if (we) begin
                mem[addr] <= din;
            end
            dout <= mem[addr];
        end
    end
endmodule

module mem_controller (
    input  logic              clk,
    input  logic              rst_n,
    input  logic              req,
    input  logic              we,
    input  logic [19:0]       addr,
    input  logic [31:0]       wdata,
    input  logic [3:0]        wstrb,
    input  logic [3:0]        burst_len,
    output logic              ready,
    output logic [31:0]       rdata,
    output logic              rvalid
);
    localparam int ADDR_W_TOP = 20;
    localparam int BANK_ADDR_W = 16;
    localparam int DATA_W = 32;

    typedef enum logic [2:0] {IDLE, DECODE, ISSUE, WAIT, RESP} state_e;
    state_e state;

    logic [ADDR_W_TOP-1:0] addr_latched;
    logic                  we_latched;
    logic [DATA_W-1:0]     wdata_latched;
    logic [3:0]            wstrb_latched;
    logic [3:0]            burst_len_latched;
    logic [3:0]            burst_cnt;

    logic [13:0]           row_index;
    logic [1:0]            col_index;
    logic [4:0]            sh;

    logic [DATA_W-1:0]     read_data_reg;
    logic [DATA_W-1:0]     write_data_aligned;
    logic [DATA_W-1:0]     s_din;
    logic [DATA_W-1:0]     s_dout;
    logic                  s_en;
    logic                  s_we;

    logic [31:0]           byte_mask;
    logic [7:0]            data_write_byte;
    logic                  parity_bit;

    assign data_write_byte = wdata_latched;

    always_comb begin
        parity_bit = ^data_write_byte;
    end

    always_comb begin
        sh = {col_index, 3'b000};
        write_data_aligned = wdata_latched << sh;
    end

    always_comb begin
        byte_mask = 32'h0000_0000;
        for (int i = 0; i < 4; i++) begin
            if (wstrb_latched[i]) begin
                byte_mask[i*8 +: 8] = 8'hFF;
            end
        end
    end

    always_comb begin
        s_en  = 1'b0;
        s_we  = 1'b0;
        s_din = 32'h0000_0000;
        if (state == ISSUE) begin
            s_en  = 1'b1;
            s_we  = we_latched;
            s_din = (write_data_aligned & byte_mask) ^ {31'd0, parity_bit};
        end
    end

    sram_bank #(.ADDR_W(BANK_ADDR_W), .DATA_W(DATA_W)) u_sram (
        .clk(clk),
        .en(s_en),
        .we(s_we),
        .addr(row_index),
        .din(s_din),
        .dout(s_dout)
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state              <= IDLE;
            ready              <= 1'b1;
            rvalid             <= 1'b0;
            read_data_reg      <= '0;
            addr_latched       <= '0;
            we_latched         <= 1'b0;
            wdata_latched      <= '0;
            wstrb_latched      <= '0;
            burst_len_latched  <= '0;
            burst_cnt          <= '0;
            row_index          <= '0;
            col_index          <= '0;
        end else begin
            rvalid <= 1'b0;
            case (state)
                IDLE: begin
                    ready <= 1'b1;
                    if (req) begin
                        ready             <= 1'b0;
                        addr_latched      <= addr;
                        we_latched        <= we;
                        wdata_latched     <= wdata;
                        wstrb_latched     <= wstrb;
                        burst_len_latched <= burst_len;
                        burst_cnt         <= 4'd0;
                        state             <= DECODE;
                    end
                end
                DECODE: begin
                    row_index <= addr_latched[19:6];
                    col_index <= addr_latched[5:4];
                    state     <= ISSUE;
                end
                ISSUE: begin
                    state <= WAIT;
                end
                WAIT: begin
                    state <= RESP;
                end
                RESP: begin
                    if (!we_latched) begin
                        rvalid        <= 1'b1;
                        read_data_reg <= s_dout >> sh;
                    end
                    if (burst_cnt == burst_len_latched) begin
                        state <= IDLE;
                        ready <= 1'b1;
                    end else begin
                        burst_cnt    <= burst_cnt + 4'd1;
                        addr_latched <= addr_latched + 20'd4;
                        state        <= DECODE;
                    end
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

    assign rdata = read_data_reg;
endmodule