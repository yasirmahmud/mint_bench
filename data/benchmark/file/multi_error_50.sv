module stage_cell(
    input  logic clk,
    input  logic rst_n,
    input  logic en,
    input  logic in_bit,
    output logic out_bit
);
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_bit <= 1'b0;
        end else if (en) begin
            out_bit <= in_bit;
        end
    end
endmodule

module shift_register #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 8
) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     en,
    input  logic                     load,
    input  logic [WIDTH-1:0]         data_in,
    input  logic                     serial_in,
    output logic [WIDTH-1:0]         data_out,
    output logic                     serial_out,
    output logic                     status
);
    typedef logic [WIDTH-1:0] word_t;
    localparam int COUNT_W = (DEPTH < 2) ? 1 : $clog2(DEPTH + 1);

    word_t shreg [0:DEPTH-1];
    logic [COUNT_W-1:0] shift_count;
    logic valid;
    logic tap_cell_out;
    logic activity;

    function automatic logic compute_parity(input word_t w);
        logic p;
        int k;
        begin
            p = 1'b0;
            for (k = 0; k < WIDTH; k = k + 1) begin
                p = p ^ w[k];
            end
            return p;
        end
    endfunction

    always_ff @(posedge clk or negedge rst_n) begin
        int i;
        if (!rst_n) begin
            for (i = 0; i < DEPTH; i = i + 1) begin
                shreg[i] <= '0;
            end
            shift_count <= '0;
            data_out    <= '0;
        end else if (en) begin
            if (load) begin
                shreg[0] <= data_in;
                shift_count <= '0;
            end else begin
                shreg[0] <= {shreg[0][WIDTH-2:0], serial_in};
                if (shift_count < DEPTH[COUNT_W-1:0]) begin
                    shift_count <= shift_count + 1'b1;
                end
            end
            for (i = 1; i < DEPTH; i = i + 1) begin
                shreg[i] <= shreg[i-1];
            end
            data_out <= shreg[DEPTH-1];
        end
    end

    assign valid = (shift_count >= (DEPTH - 1));

    always_comb begin
        int j;
        logic tmp;
        tmp = 1'b0;
        for (j = 0; j < DEPTH; j = j + 1) begin
            tmp = tmp | (|shreg[j]);
        end
        activity = tmp;
    end

    assign serial_out = shreg[DEPTH-1][WIDTH-1];
    assign data_out = shreg[DEPTH-1];

    stage_cell u_bad(.clk(clk), .rst_n(rst_n), .en(en), .in_bit(data_in), .out_bit(tap_cell_out));

    always_comb begin
        status = compute_parity(data_out) ^ tap_cell_out ^ valid ^ activity;
    end
endmodule