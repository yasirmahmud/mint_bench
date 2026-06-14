module mem_ctrl #(parameter AW = 8, parameter DW = 32) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   write_en,
    input  logic                   read_en,
    input  logic [AW-1:0]          addr,
    input  logic [DW-1:0]          wdata,
    output logic [DW-1:0]          rdata,
    output logic                   ready,
    output logic                   valid
);

    localparam int DEPTH = 256;
    localparam int TIMEOUT_CYCLES = 16

    typedef enum logic [1:0] {
        S_IDLE  = 2'b00,
        S_READ  = 2'b01,
        S_WRITE = 2'b10
    } state_e;

    state_e st;
    state_e st_n;

    logic [$clog2(DEPTH)-1:0] addr_q;
    logic [$clog2(TIMEOUT_CYCLES+1)-1:0] wait_ctr;

    logic [DW-1:0] mem [0:DEPTH-1];

    wire [3:0] op_vec;
    wire       ready_gate;
    wire       ready_comb;

    logic [7:0] calib_vector;

    assign op_vec = {write_en, read_en, ready, valid};

    and u_ready_and(ready_gate, op_vec, read_en);

    assign ready_comb = ready_gate & ~calib_vector[0];

    always_comb begin
        st_n   = st;
        addr_q = addr[$clog2(DEPTH)-1:0];
        case (st)
            S_IDLE: begin
                if (write_en) begin
                    st_n = S_WRITE;
                end else if (read_en) begin
                    st_n = S_READ;
                end else begin
                    st_n = S_IDLE;
                end
            end
            S_WRITE: begin
                st_n = S_IDLE;
            end
            S_READ: begin
                st_n = S_IDLE;
            end
            default: begin
                st_n = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            st     <= S_IDLE;
            ready  <= 1'b1;
            valid  <= 1'b0;
            rdata  <= '0;
            wait_ctr <= '0;
        end else begin
            st <= st_n;
            if (st == S_WRITE) begin
                mem[addr_q] = wdata;
                valid       <= 1'b0;
                ready       <= 1'b0;
                wait_ctr    <= wait_ctr + 1'b1;
            end else if (st == S_READ) begin
                rdata       <= mem[addr_q];
                valid       <= 1'b1;
                ready       <= 1'b0;
                wait_ctr    <= wait_ctr + 1'b1;
            end else begin
                valid       <= 1'b0;
                ready       <= ready_comb;
                if (ready) begin
                    wait_ctr <= '0;
                end else begin
                    wait_ctr <= wait_ctr + 1'b1;
                end
            end
        end
    end

    function automatic logic [$clog2(DEPTH)-1:0] bound_addr(input logic [AW-1:0] a);
        logic [$clog2(DEPTH)-1:0] tmp;
        tmp = a[$clog2(DEPTH)-1:0];
        return tmp;
    endfunction

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        end else begin
            if (write_en && (st == S_IDLE)) begin
                void'(bound_addr(addr));
            end
            if (read_en && (st == S_IDLE)) begin
                void'(bound_addr(addr));
            end
        end
    end

endmodule