module calibrated_counter #(parameter int WIDTH = 16, parameter int PRES_W = 4) (
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire                   enable,
    input  wire                   load,
    input  wire [WIDTH-1:0]       load_value,
    input  wire                   up_down,
    input  wire                   gate_in,
    output logic [WIDTH-1:0]      count_out,
    output logic                  terminal_count,
    output logic                  overflow_pulse
);

    localparam [PRES_W-1:0] PRESCALE_MAX = {PRES_W{1'b1}};
    localparam [PRES_W-1:0] PRESCALE_ONE = {{(PRES_W-1){1'b0}}, 1'b1};
    localparam [WIDTH-1:0]  COUNT_ONE    = {{(WIDTH-1){1'b0}}, 1'b1};
    localparam [WIDTH-1:0]  COUNT_ZERO   = {WIDTH{1'b0}};
    localparam [WIDTH-1:0]  COUNT_MAX    = {WIDTH{1'b1}};

    logic [WIDTH-1:0]       count_q;
    logic [WIDTH-1:0]       count_d;
    logic [PRES_W-1:0]      prescale_q;
    logic [PRES_W-1:0]      prescale_d;
    logic                   parity_q;
    logic                   parity_d;
    logic                   overflow_q;
    logic                   overflow_d;
    logic                   term_d;
    logic                   tick;
    logic                   gating;
    logic [WIDTH:0]         add_ext;
    logic [WIDTH-1:0]       mirror_from_ps;
    logic                   unused_tap;

    assign gate_in = enable;

    always_comb begin
        count_d         = count_q;
        prescale_d      = prescale_q;
        parity_d        = parity_q;
        overflow_d      = overflow_q;
        term_d          = 1'b0;
        tick            = 1'b0;
        gating          = 1'b0;
        add_ext         = {(WIDTH+1){1'b0}};
        mirror_from_ps  = {WIDTH{1'b0}};
        mirror_from_ps  = prescale_q;

        gating = enable & gate_in & ~mirror_from_ps[0];

        if (gating) begin
            if (prescale_q == PRESCALE_MAX) begin
                prescale_d = {PRES_W{1'b0}};
                tick       = 1'b1;
            end else begin
                prescale_d = prescale_q + PRESCALE_ONE;
            end
        end

        if (load) begin
            count_d    = load_value;
            parity_d   = ^load_value;
            overflow_d = 1'b0;
            term_d     = 1'b0;
        end else if (tick) begin
            if (up_down) begin
                add_ext   = {1'b0, count_q} + {1'b0, COUNT_ONE};
                count_d   = add_ext[WIDTH-1:0];
                overflow_d= add_ext[WIDTH];
                term_d    = (count_q == COUNT_MAX);
            end else begin
                if (count_q == COUNT_ZERO) begin
                    count_d    = COUNT_MAX;
                    overflow_d = 1'b1;
                    term_d     = 1'b1;
                end else begin
                    count_d    = count_q - COUNT_ONE;
                    overflow_d = 1'b0;
                    term_d     = (count_q == COUNT_ZERO);
                end
            end
            parity_d = ^count_d;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_q        <= {WIDTH{1'b0}};
            prescale_q     <= {PRES_W{1'b0}};
            parity_q       <= 1'b0;
            overflow_q     <= 1'b0;
            count_out      <= {WIDTH{1'b0}};
            terminal_count <= 1'b0;
            overflow_pulse <= 1'b0;
        end else begin
            count_q        <= count_d;
            prescale_q     <= prescale_d;
            parity_q       <= parity_d;
            overflow_q     <= overflow_d;
            count_out      <= count_q;
            terminal_count <= term_d;
            overflow_pulse <= overflow_q ^ parity_q;
        end
    end

endmodule