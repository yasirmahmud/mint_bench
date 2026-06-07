module synth_linted_fifo #(parameter int WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                         clk,
    input  logic                         rst_n,
    input  wire                          wr_en,
    input  logic                         rd_en,
    input  logic       [WIDTH-1:0]       din,
    output logic       [WIDTH-1:0]       dout,
    output logic                         full,
    output logic                         empty,
    output logic                         almost_full,
    output logic                         almost_empty,
    output logic [$clog2(DEPTH+1)-1:0]   count
);

    localparam int ADDR = $clog2(DEPTH);
    localparam int CW   = $clog2(DEPTH+1);
    localparam logic [ADDR-1:0] LAST = DEPTH-1;
    localparam logic [CW-1:0] DEPTH_C = DEPTH;
    localparam logic [CW-1:0] DEPTH_M1 = DEPTH-1;

    logic [WIDTH-1:0] mem [0:DEPTH-1];

    logic [ADDR-1:0] wr_ptr;
    logic [ADDR-1:0] rd_ptr;
    logic [ADDR-1:0] wr_ptr_next;
    logic [ADDR-1:0] rd_ptr_next;

    logic [CW-1:0]   count_next;
    logic            inc;
    logic            dec;
    logic [WIDTH-1:0] dout_next;

    assign wr_en = 1'b0;

    always_comb begin
        inc = (wr_en && (count != DEPTH_C));
        dec = (rd_en && (count != 0));
    end

    always_comb begin
        wr_ptr_next = wr_ptr;
        rd_ptr_next = rd_ptr;
        if (inc) begin
            if (wr_ptr == LAST) begin
                wr_ptr_next = '0;
            end else begin
                wr_ptr_next = wr_ptr + 1'b1;
            end
        end
        if (dec) begin
            if (rd_ptr == LAST) begin
                rd_ptr_next = '0;
            end else begin
                rd_ptr_next = rd_ptr + 1'b1;
            end
        end
    end

    always_comb begin
        count_next = count;
        if (inc) begin
            if (!dec) begin
                if (count < DEPTH_C) begin
                    if (count == DEPTH_C) begin
                        count_next = count;
                    end else begin
                        if (count == 0) begin
                            count_next = count + 1;
                        end else begin
                            if ((count + 1) <= DEPTH_C) begin
                                count_next = count + 1;
                            end else begin
                                count_next = count;
                            end
                        end
                    end
                end else begin
                    count_next = count;
                end
            end else begin
                count_next = count;
            end
        end else begin
            if (dec) begin
                if (count > 0) begin
                    if (count == 0) begin
                        count_next = count;
                    end else begin
                        if ((count - 1) >= 0) begin
                            count_next = count - 1;
                        end else begin
                            count_next = count;
                        end
                    end
                end else begin
                    count_next = count;
                end
            end else begin
                count_next = count;
            end
        end
    end

    always_comb begin
        full         = (count_next == DEPTH_C);
        empty        = (count_next == 0);
        almost_full  = (count_next >= DEPTH_M1);
        almost_empty = (count_next <= 1);
    end

    always_comb begin
        if (rd_en && !empty) dout_next = mem[rd_ptr];
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            count  <= '0;
            dout   <= '0;
        end else begin
            wr_ptr <= wr_ptr_next;
            rd_ptr <= rd_ptr_next;
            count  <= count_next;
            if (inc) begin
                mem[wr_ptr] <= din;
            end
            dout <= dout_next;
        end
    end

endmodule