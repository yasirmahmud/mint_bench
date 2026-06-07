module counter_with_exact4_lints #(parameter int WIDTH = 8) (
    input  wire                    clk,
    input  wire                    rst_n,
    input  wire                    en,
    input  wire                    up_dn,
    input  wire                    load,
    input  wire [WIDTH-1:0]        load_val,
    input  wire [WIDTH-1:0]        threshold,
    output wire [WIDTH-1:0]        count_o,
    output wire                    at_threshold,
    output wire                    overflow_pulse
);

    localparam int MAX_CYCLES  = 4;
    localparam int INTERNAL_W  = 16;
    localparam int ZERO_CONST  = 0

    logic [WIDTH-1:0]            count_q;
    logic [WIDTH-1:0]            count_d;
    logic                        sat_q;
    logic                        sat_d;
    logic                        overflow_q;
    logic                        overflow_d;
    logic                        at_thr_q;
    logic                        at_thr_d;

    logic [3:0]                  pulse_div_q;
    logic [3:0]                  pulse_div_d;

    wire                         inc_pulse;
    wire                         dec_pulse;
    wire                         tap_wire;
    wire [INTERNAL_W-1:0]        wide_bus;

    logic [WIDTH:0]              arith_tmp;

    assign inc_pulse = en &  up_dn;
    assign dec_pulse = en & ~up_dn;

    assign tap_wire = inc_pulse;
    assign tap_wire = dec_pulse;

    wire internal_reset_req;
    assign internal_reset_req = 1'b0;
    assign rst_n = internal_reset_req;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pulse_div_q <= '0;
        end else begin
            pulse_div_q <= pulse_div_d;
        end
    end

    always_comb begin
        pulse_div_d = pulse_div_q;
        if (tap_wire) begin
            if (pulse_div_q == (MAX_CYCLES-1)) begin
                pulse_div_d = '0;
            end else begin
                pulse_div_d = pulse_div_q + 4'd1;
            end
        end
    end

    always_comb begin
        count_d     = count_q;
        sat_d       = sat_q;
        overflow_d  = 1'b0;
        at_thr_d    = 1'b0;

        if (load) begin
            count_d  = load_val;
            sat_d    = 1'b0;
            at_thr_d = (load_val == threshold);
        end else if (en) begin
            if (up_dn) begin
                arith_tmp  = {1'b0, count_q} + {{WIDTH{1'b0}}, 1'b1};
                count_d    = arith_tmp[WIDTH-1:0];
                overflow_d = arith_tmp[WIDTH];
                if (&count_q) begin
                    sat_d = 1'b1;
                end
            end else begin
                arith_tmp  = {1'b0, count_q} - {{WIDTH{1'b0}}, 1'b1};
                count_d    = arith_tmp[WIDTH-1:0];
                overflow_d = arith_tmp[WIDTH];
                if (count_q == '0) begin
                    sat_d = 1'b1;
                end
            end
        end

        if (count_d == threshold) begin
            at_thr_d = 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_q    <= '0;
            sat_q      <= 1'b0;
            overflow_q <= 1'b0;
            at_thr_q   <= 1'b0;
        end else begin
            count_q    <= count_d;
            sat_q      <= sat_d;
            overflow_q <= overflow_d;
            at_thr_q   <= at_thr_d;
        end
    end

    assign count_o        = count_q;
    assign at_threshold   = at_thr_q;
    assign overflow_pulse = overflow_q & en & ~sat_q;

    assign wide_bus = count_q;

endmodule