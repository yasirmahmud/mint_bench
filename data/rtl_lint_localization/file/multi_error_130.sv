module shift_register_with_faults #(parameter int WIDTH = 8) (
    input  wire                          clk,
    input  wire                          rst_n,
    input  wire                          shift_en,
    input  logic                         load,
    input  logic                         serial_in,
    input  logic [WIDTH-1:0]             parallel_in,
    input  logic                         capture,
    output wire                          serial_out,
    output logic [WIDTH-1:0]             parallel_out,
    output wire [WIDTH-1:0]              tap_capture,
    output logic                         msb_out,
    output logic                         lsb_out,
    output logic                         parity_even,
    output logic [7:0]                   shift_count_o,
    output wire [WIDTH-1:0]              diagnostic_bus
);

    logic [WIDTH-1:0] state;
    logic [WIDTH-1:0] next_state;
    logic [WIDTH-1:0] capture_latch;
    logic [WIDTH-1:0] rotated_state;
    logic [WIDTH-1:0] masked_in;
    logic [WIDTH-1:0] mask;
    logic [7:0]       shift_count;
    wire              gate_en;

    always_comb begin
        mask = {WIDTH{1'b1}};
        masked_in = parallel_in & mask;
    end

    always_comb begin
        next_state = state;
        if (load) begin
            next_state = masked_in;
        end else if (shift_en) begin
            next_state = {state[WIDTH-2:0], serial_in};
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= '0;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_count <= 8'd0;
        end else if (shift_en) begin
            shift_count <= shift_count + 8'd1;
        end
    end

    always_comb begin
        parallel_out = state;
        msb_out = state[WIDTH-1];
        lsb_out = state[0];
        parity_even = ^state;
        shift_count_o = shift_count;
    end

    assign serial_out = state;

    always_comb begin
        rotated_state = {state[WIDTH-2:0], state[WIDTH-1]};
    end

    assign diagnostic_bus = rotated_state ^ masked_in;

    assign tap_capture = capture_latch;

    always_comb begin
        if (capture) begin
            capture_latch <= state;
        end
    end

    assign gate_en = load & capture;

    assign shift_en = gate_en;

endmodule