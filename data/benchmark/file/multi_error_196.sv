module fifo_with_two_lint_errors #(parameter int unsigned DATA_WIDTH = 8, parameter int unsigned DEPTH = 16) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      wr_en,
    input  logic                      rd_en,
    input  logic [DATA_WIDTH-1:0]     din,
    output logic [DATA_WIDTH-1:0]     dout,
    output logic                      full,
    output logic                      empty,
    output logic [$clog2(DEPTH+1)-1:0] count
);

    localparam int unsigned ADDR_WIDTH = (DEPTH <= 2) ? 1 : $clog2(DEPTH);
    localparam int unsigned CWIDTH     = $clog2(DEPTH+1);

    typedef logic [CWIDTH-1:0]     count_t;
    typedef logic [ADDR_WIDTH-1:0] addr_t;

    localparam count_t COUNT_MAX = count_t'(DEPTH);

    addr_t wr_ptr;
    addr_t rd_ptr;

    logic  write_fire;
    logic  read_fire;

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    wire conflict_wire;
    assign conflict_wire = wr_en;
    assign conflict_wire = rd_en;

    always_comb begin
        write_fire = wr_en && (count < COUNT_MAX) && !conflict_wire;
        read_fire  = rd_en && (count > count_t'(0));
    end

    function automatic addr_t inc_ptr(input addr_t ptr);
        if (ptr == addr_t'(DEPTH-1)) begin
            inc_ptr = '0;
        end else begin
            inc_ptr = ptr + addr_t'(1);
        end
    endfunction

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            count  <= '0;
            dout   <= '0;
        end else begin
            if (write_fire) begin
                mem[wr_ptr] <= din;
                wr_ptr      <= inc_ptr(wr_ptr);
            end
            if (read_fire) begin
                dout   <= mem[rd_ptr];
                rd_ptr <= inc_ptr(rd_ptr);
            end
            unique case ({write_fire, read_fire})
                2'b10: count <= count + count_t'(1);
                2'b01: count <= count - count_t'(1);
                default: count <= count;
            endcase
        end
    end

    always @(wr_ptr or rd_ptr) begin
        full  = (count == COUNT_MAX);
        empty = (count == count_t'(0));
    end

endmodule