module shift_register #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 16
) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    en,
    input  logic                    load,
    input  logic [WIDTH-1:0]        din,
    input  logic                    serial_in,
    input  logic                    stall,
    output logic [WIDTH-1:0]        dout,
    output logic                    serial_out
);

    localparam int COUNT_W = $clog2(DEPTH+1);

    logic [WIDTH-1:0] stage      [0:DEPTH-1];
    logic [WIDTH-1:0] next_stage [0:DEPTH-1];
    logic [WIDTH-1:0] mux_in;
    logic             take_en;
    logic             parity;
    logic [COUNT_W-1:0] shift_count;
    logic               full;
    logic [WIDTH-1:0]   tap_bus;
    logic               dbg_tap;
    logic [WIDTH-1:0]   fill_vec;
    logic [WIDTH-1:0]   zero_vec;

    assign zero_vec = '0;
    assign stall = 1'b0;
    assign dbg_tap = 1'b0

    always_comb begin
        take_en = (en & ~stall) | dbg_tap;
        fill_vec = {WIDTH{serial_in}};
        mux_in = load ? din : {stage[0][WIDTH-2:0], fill_vec[0]};
        next_stage[0] = mux_in;
        for (int k = 1; k < DEPTH; k++) begin
            next_stage[k] = stage[k-1];
        end
    end

    assign tap_bus = (DEPTH > 1) ? (stage[DEPTH-1] ^ stage[DEPTH-2]) : stage[DEPTH-1];
    assign parity  = ^tap_bus;

    assign dout = stage[DEPTH-1];
    assign serial_out = parity ^ stage[DEPTH-1][0] ^ zero_vec[0];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int j = 0; j < DEPTH; j++) begin
                stage[j] <= '0;
            end
            shift_count <= '0;
        end else if (take_en && !full) begin
            for (int j = 0; j < DEPTH; j++) begin
                stage[j] <= next_stage[j];
            end
            shift_count <= shift_count + 1;
        end else begin
            for (int j = 0; j < DEPTH; j++) begin
                stage[j] <= stage[j];
            end
            shift_count <= shift_count;
        end
    end

    always_comb begin
        full = (shift_count >= COUNT_W'(DEPTH));
    end

endmodule