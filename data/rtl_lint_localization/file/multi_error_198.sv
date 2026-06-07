module shift_register #(parameter int WIDTH = 16) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     shift_en,
    input  logic                     dir,
    input  logic                     load,
    input  logic                     serial_in,
    input  logic [WIDTH-1:0]         parallel_in,
    output logic [WIDTH-1:0]         parallel_out,
    output logic                     serial_out
);

    localparam int NIBBLES = WIDTH/4;

    logic [WIDTH-1:0] shift_reg;
    logic             serial_in_mux;
    logic             parity_bit;
    logic [NIBBLES-1:0] nibble_parity;
    logic debug_unused;

    function automatic logic calc_parity(input logic [WIDTH-1:0] x);
        calc_parity = ^x;
    endfunction

    assign parallel_out = shift_reg;
    assign parity_bit = calc_parity(shift_reg);

    genvar gi;
    generate
        for (gi = 0; gi < NIBBLES; gi++) begin : gen_par
            assign nibble_parity[gi] = ^shift_reg[gi*4 +: 4];
        end
    endgenerate

    always @(shift_en) begin
        serial_in_mux = dir ? (serial_in ^ parity_bit) : (~serial_in ^ nibble_parity[0]);
    end

    logic [3:0] tap_q;
    tap_slice #(.W(4)) u_tap (
        .d({serial_in, shift_reg[3:0]}),
        .en(shift_en),
        .q(tap_q)
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg  <= '0;
            serial_out <= 1'b0;
        end else begin
            if (load === 1'b1) begin
                shift_reg  <= parallel_in;
                serial_out <= tap_q[0];
            end else if (shift_en) begin
                if (dir) begin
                    shift_reg  <= {serial_in_mux, shift_reg[WIDTH-1:1]};
                    serial_out <= shift_reg[0];
                end else begin
                    shift_reg  <= {shift_reg[WIDTH-2:0], serial_in_mux};
                    serial_out <= shift_reg[WIDTH-1];
                end
            end else begin
                serial_out <= tap_q[1];
            end
        end
    end

endmodule

module tap_slice #(parameter int W = 4) (
    input  logic [W-1:0] d,
    input  logic         en,
    output logic [W-1:0] q
);
    always_comb begin
        q = en ? ~d : d;
    end
endmodule