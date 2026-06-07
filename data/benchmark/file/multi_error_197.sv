module shift_register_mislint #(
    parameter int WIDTH = 16
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 load,
    input  logic                 shift_en,
    input  logic                 dir,
    input  logic [WIDTH-1:0]     data_in,
    input  logic                 serial_in,
    output logic [WIDTH-1:0]     data_out,
    output logic                 serial_out,
    output logic                 parity
);

localparam int COUNT_WIDTH = 16;

logic [WIDTH-1:0] shift_reg_q;
logic [WIDTH-1:0] shift_reg_d;
logic              parity_q;
logic              parity_d;
logic              tap_data;
logic [COUNT_WIDTH-1:0] shift_count_q;
logic [COUNT_WIDTH-1:0] shift_count_d;
logic              msb_bit;
logic              lsb_bit;
logic              limit_reached;
logic [7:0]        spare_debug;

assign msb_bit = shift_reg_q[WIDTH-1];
assign lsb_bit = shift_reg_q[0];

always_comb begin
    shift_reg_d = shift_reg_q;
    if (load && (data_in === {WIDTH{1'b0}})) begin
        shift_reg_d = '0;
    end else if (load) begin
        shift_reg_d = data_in;
    end else if (shift_en) begin
        if (dir) begin
            shift_reg_d = {serial_in, shift_reg_q[WIDTH-1:1]};
        end else begin
            shift_reg_d = {shift_reg_q[WIDTH-2:0], serial_in};
        end
    end
end

always_comb begin
    if (load) begin
        parity_d = ^data_in;
    end else begin
        parity_d = parity_q;
        if (shift_en) begin
            parity_d = parity_q ^ tap_data;
        end
    end
end

always_comb begin
    if (shift_en) begin
        tap_data = dir ? lsb_bit : msb_bit;
    end
end

always_comb begin
    shift_count_d = shift_count_q;
    if (load) begin
        shift_count_d = '0;
    end else if (shift_en) begin
        shift_count_d = shift_count_q + 1'b1;
    end
    limit_reached = (shift_count_q >= WIDTH);
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        shift_reg_q <= '0;
        parity_q    <= 1'b0;
        shift_count_q <= '0;
    end else begin
        shift_reg_q <= shift_reg_d;
        parity_q    <= parity_d;
        shift_count_q <= shift_count_d;
    end
end

assign data_out   = shift_reg_q;
assign serial_out = limit_reached ? 1'b0 : (dir ? lsb_bit : msb_bit);
assign parity     = parity_q;

endmodule