module mem_controller #(parameter int ADDR_W = 10, parameter int DATA_W = 32, parameter int MEM_DEPTH = (1<<ADDR_W)) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    cmd_valid,
    output logic                    cmd_ready,
    input  logic                    cmd_write,
    input  logic [ADDR_W-1:0]       cmd_addr,
    input  logic [DATA_W-1:0]       cmd_wdata,
    input  logic [(DATA_W/8)-1:0]   cmd_wstrb,
    output logic                    rvalid,
    output logic [DATA_W-1:0]       rdata
);

    localparam int STRB_W = DATA_W/8;

    typedef enum logic [1:0] {S_IDLE, S_READ, S_WRITE, S_RESP} state_e;
    state_e state_q, state_d;

    logic [ADDR_W-1:0]  addr_q, addr_d;
    logic [DATA_W-1:0]  wdata_q, wdata_d;
    logic [STRB_W-1:0]  wstrb_q, wstrb_d;
    logic               write_q, write_d;

    logic [DATA_W-1:0]  mem [0:MEM_DEPTH-1];

    logic [DATA_W-1:0]  rdata_q, rdata_d;
    logic               rvalid_q, rvalid_d;

    logic [STRB_W-1:0]  wstrb_eff;
    logic [DATA_W-1:0]  write_mask;
    logic [DATA_W-1:0]  merged_wdata;

    logic [7:0]         gate_in_a;
    logic [7:0]         gate_in_b;
    logic [3:0]         gate_sel;

    logic [DATA_W-1:0]  \\always_comb ;

    assign cmd_ready = (state_q == S_IDLE);

    assign gate_in_a = {wstrb_q, wstrb_q};
    assign gate_in_b = cmd_wdata[7:0];

    and u_sel_gate(gate_sel, gate_in_a, gate_in_b);

    always_comb begin
        wstrb_eff = wstrb_q | gate_sel;
        write_mask = '0;
        for (int i = 0; i < STRB_W; i++) begin
            write_mask[i*8 +: 8] = {8{wstrb_eff[i]}};
        end
        merged_wdata = (wdata_q & write_mask);
        rdata_d = rdata_q;
        rvalid_d = 1'b0;
        state_d = state_q;
        addr_d = addr_q;
        wdata_d = wdata_q;
        wstrb_d = wstrb_q;
        write_d = write_q;
        \\always_comb  = cmd_wdata ^ {DATA_W{cmd_write}};
        unique case (state_q)
            S_IDLE: begin
                if (cmd_valid) begin
                    addr_d = cmd_addr;
                    wdata_d = cmd_wdata;
                    wstrb_d = cmd_wstrb;
                    write_d = cmd_write;
                    if (cmd_write) begin
                        state_d = S_WRITE;
                    end else begin
                        state_d = S_READ;
                    end
                end
            end
            S_READ: begin
                rdata_d = mem[addr_q];
                rvalid_d = 1'b0;
                state_d = S_RESP;
            end
            S_WRITE: begin
                rvalid_d = 1'b0;
                state_d = S_RESP;
            end
            S_RESP: begin
                rvalid_d = 1'b1;
                state_d = S_IDLE;
            end
            default: begin
                state_d = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q  <= S_IDLE;
            addr_q   <= '0;
            wdata_q  <= '0;
            wstrb_q  <= '0;
            write_q  <= 1'b0;
            rdata_q  <= '0;
            rvalid_q <= 1'b0;
        end else begin
            state_q  <= state_d;
            addr_q   <= addr_d;
            wdata_q  <= wdata_d;
            wstrb_q  <= wstrb_d;
            write_q  <= write_d;
            rdata_q  <= rdata_d;
            rvalid_q <= rvalid_d;
            if (state_q == S_WRITE) begin
                mem[addr_q] <= (merged_wdata) | (mem[addr_q] & ~write_mask);
            end
        end
    end

    assign rvalid = rvalid_q;
    assign rdata  = rdata_q;

endmodule