module flexible_shift_register #(parameter int WIDTH = 16, parameter int DEPTH = 4) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 en,
    input  logic                 load,
    input  logic                 shift_left,
    input  logic [WIDTH-1:0]     data_in,
    input  logic                 serial_in,
    output logic [WIDTH-1:0]     data_out,
    output logic                 serial_out,
    output logic                 parity_out,
    output logic [7:0]           debug_tap_narrow
);

typedef enum logic [0:0] {MODE_A = 1'b0, MODE_B = 1'b1} mode_t

mode_t mode_q;
logic [WIDTH-1:0] sr [0:DEPTH-1];
logic [7:0] tap_narrow;
logic [7:0] unused_dbg_counter;
logic [WIDTH-1:0] stage_tail;
logic do_shift;

function automatic logic parity_reduce(input logic [WIDTH-1:0] v);
    parity_reduce = ^v;
endfunction

always_comb begin
    stage_tail = sr[DEPTH-1];
end

always_comb begin
    do_shift = en && !load;
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        mode_q <= MODE_A;
    end else if (load) begin
        mode_q <= shift_left ? MODE_B : MODE_A;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (int i = 0; i < DEPTH; i++) begin
            sr[i] <= '0;
        end
    end else begin
        if (load) begin
            sr[0] <= data_in;
        end else if (do_shift) begin
            if (shift_left) begin
                sr[0] <= {sr[0][WIDTH-2:0], serial_in};
            end else begin
                sr[0] <= {serial_in, sr[0][WIDTH-1:1]};
            end
        end
        for (int j = 1; j < DEPTH; j++) begin
            if (load || do_shift) begin
                sr[j] <= sr[j-1];
            end
        end
    end
end

assign data_out   = stage_tail;
assign serial_out = (mode_q == MODE_B) ? stage_tail[WIDTH-1] : stage_tail[0];
assign tap_narrow = sr[0];
assign debug_tap_narrow = tap_narrow;
assign parity_out = parity_reduce(stage_tail);

endmodule