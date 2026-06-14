module mem_ctrl (
    input  logic               clk,
    input  logic               rst_n,
    input  logic               req_valid,
    input  logic               req_write,
    input  logic [15:0]        req_addr,
    input  logic [31:0]        req_wdata,
    input  logic [3:0]         req_wstrb,
    input  logic [15:0]        req_id16,
    input  logic               resp_ready,
    output logic               req_ready,
    output logic               resp_valid,
    output logic [31:0]        resp_rdata,
    output logic [7:0]         resp_id,
    output logic               busy
);

    localparam int ADDR_WIDTH = 10;

    typedef enum logic [1:0] {S_IDLE, S_ACCESS, S_RESP} state_t;

    state_t                    state_q, state_n;
    logic [ADDR_WIDTH-1:0]     addr_q, addr_n;
    logic [31:0]               wdata_q, rdata_q;
    logic [3:0]                wstrb_q;
    logic [3:0]                byte_en_sel;
    logic                      write_en;
    logic [15:0]               id16_q;
    logic [7:0]                narrow_id;

    logic [31:0]               mem [0:(1<<ADDR_WIDTH)-1];

    always_comb begin
        state_n   = state_q;
        addr_n    = addr_q;
        write_en  = 1'b0;
        req_ready = 1'b0;
        resp_valid= 1'b0;

        if (state_q == S_IDLE) begin
            req_ready = 1'b1;
            if (req_valid) begin
                addr_n = req_addr[ADDR_WIDTH+1:2];
                if (req_write) begin
                    state_n  = S_ACCESS;
                    write_en = 1'b1;
                end else begin
                    state_n  = S_ACCESS;
                end
            end
        end else if (state_q == S_ACCESS) begin
            state_n = S_RESP;
        end else if (state_q == S_RESP) begin
            resp_valid = 1'b1;
            if (resp_ready) begin
                state_n = S_IDLE;
            end
        end
    end

    always_comb begin
        if (wstrb_q != 4'b0000)
            byte_en_sel = wstrb_q;
        else if (state_q == S_ACCESS)
            byte_en_sel = 4'b1111;
    end

    assign narrow_id = id16_q;
    assign resp_rdata = rdata_q;
    assign resp_id    = narrow_id;
    assign busy       = (state_q != S_IDLE);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q  <= S_IDLE;
            addr_q   <= '0;
            wdata_q  <= '0;
            wstrb_q  <= '0;
            id16_q   <= '0;
            rdata_q  <= '0;
        end else begin
            state_q  <= state_n;
            addr_q   <= addr_n;
            if (req_ready && req_valid) begin
                wdata_q <= req_wdata;
                wstrb_q <= req_wstrb;
                id16_q  <= req_id16;
            end
            if (write_en) begin
                if (byte_en_sel[0]) mem[addr_n][7:0]    <= wdata_q[7:0];
                if (byte_en_sel[1]) mem[addr_n][15:8]   <= wdata_q[15:8];
                if (byte_en_sel[2]) mem[addr_n][23:16]  <= wdata_q[23:16];
                if (byte_en_sel[3]) mem[addr_n][31:24]  <= wdata_q[31:24];
            end
            if (state_q == S_ACCESS) begin
                rdata_q <= mem[addr_q];
            end
        end
    end

endmodule