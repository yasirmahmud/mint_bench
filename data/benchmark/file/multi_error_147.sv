module smart_counter #(parameter int WIDTH = 16, parameter int PRESC_WIDTH = 4) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      enable,
    input  logic                      up,
    input  logic                      hold,
    input  logic                      load,
    input  logic                      clear_ovf,
    input  logic [WIDTH-1:0]          load_value,
    input  logic [WIDTH-1:0]          step,
    input  logic [WIDTH-1:0]          threshold,
    output logic [WIDTH-1:0]          count_out,
    output logic                      terminal_flag,
    output logic                      wrap_pulse_out,
    output logic                      sticky_overflow_out,
    output logic                      even_parity_out
);

    localparam logic [PRESC_WIDTH-1:0] PRESC_MAX = {PRESC_WIDTH{1'b1}};

    logic [WIDTH-1:0]                  count;
    logic [WIDTH-1:0]                  next_count;
    logic [PRESC_WIDTH-1:0]            presc;
    logic [PRESC_WIDTH-1:0]            next_presc;
    logic                              wrap_pulse;
    logic                              next_wrap_pulse;
    logic                              sticky_overflow;
    logic                              next_sticky_overflow;
    logic                              terminal_match;
    logic                              presc_hit;
    logic [WIDTH:0]                    add_ext;
    logic [WIDTH:0]                    sub_ext;

    always_comb begin
        next_count          = count;
        next_presc          = presc;
        next_wrap_pulse     = 1'b0;
        next_sticky_overflow= sticky_overflow;
        presc_hit           = (presc == PRESC_MAX);

        if (load) begin
            next_count      = load_value;
            next_presc      = '0;
            next_wrap_pulse = 1'b0;
        end else begin
            if (enable && !hold) begin
                if (presc_hit) begin
                    if (up) begin
                        add_ext        = {1'b0, count} + {1'b0, step};
                        next_count     = add_ext[WIDTH-1:0];
                        next_wrap_pulse= add_ext[WIDTH];
                    end else begin
                        sub_ext        = {1'b0, count} - {1'b0, step};
                        next_count     = sub_ext[WIDTH-1:0];
                        next_wrap_pulse= sub_ext[WIDTH];
                    end
                    next_presc         = '0;
                end else begin
                    next_presc         = presc + {{(PRESC_WIDTH-1){1'b0}}, 1'b1};
                end
            end
        end

        if (clear_ovf) begin
            next_sticky_overflow = 1'b0;
        end else begin
            if (next_wrap_pulse) begin
                next_sticky_overflow = 1'b1;
            end
        end

        terminal_match = (count === threshold);
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            count            <= '0;
            presc            <= '0;
            sticky_overflow  <= 1'b0;
        end else begin
            count            <= next_count;
            presc            <= next_presc;
            sticky_overflow  <= next_sticky_overflow;
        end
        wrap_pulse = (!rst_n) ? 1'b0 : next_wrap_pulse;
    end

    assign count_out            = count;
    assign wrap_pulse_out       = wrap_pulse;
    assign sticky_overflow_out  = sticky_overflow;
    assign terminal_flag        = terminal_match;
    assign even_parity_out      = ~^count;

endmodule