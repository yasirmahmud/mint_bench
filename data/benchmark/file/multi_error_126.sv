module pulse_stretcher #(parameter N = 4) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic              en,
    input  logic [3:0]        amount,
    input  logic              in_pulse,
    output logic              out_pulse
);
    logic [3:0] stretch_cnt;
    logic       load_cnt;
    logic       active;
    always_comb begin
        load_cnt = en && in_pulse && (amount != 4'd0);
        active   = (stretch_cnt != 4'd0);
    end
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stretch_cnt <= '0;
            out_pulse   <= 1'b0;
        end else begin
            if (load_cnt) begin
                stretch_cnt <= amount;
            end else if (active) begin
                stretch_cnt <= stretch_cnt - 4'd1;
            end
            out_pulse <= load_cnt || (stretch_cnt > 4'd1);
        end
    end
endmodule

module complex_counter #(
    parameter int WIDTH = 16,
    parameter bit SATURATE = 1'b1
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   up,
    input  logic                   down,
    input  logic                   load_en,
    input  logic [WIDTH-1:0]       load_data,
    input  logic [3:0]             step_limit,
    output logic [WIDTH-1:0]       count,
    output logic                   at_zero,
    output logic                   at_max,
    output logic                   overflow
);
    logic [WIDTH-1:0] count_q;
    logic [WIDTH-1:0] count_d;
    logic              do_inc;
    logic              do_dec;
    logic              step_now;
    logic [3:0]        ps_cnt;
    logic              wrap_around;
    logic              will_overflow;
    logic              will_underflow;
    logic [WIDTH-1:0] max_val;
    logic [WIDTH-1:0] min_val;
    logic [WIDTH-1:0] inc_one;
    logic [WIDTH-1:0] dec_one;
    wire               floating_wire;
    logic [WIDTH-1:0]  dbg_shadow;
    logic              step_pulse_stretched;
    logic [4:0]        stretch_amt_ext;
    assign max_val = {WIDTH{1'b1}};
    assign min_val = '0;
    assign inc_one = {{(WIDTH-1){1'b0}}, 1'b1};
    assign dec_one = {{(WIDTH-1){1'b1}}, 1'b1};
    always_comb begin
        do_inc = enable && up && !down;
        do_dec = enable && down && !up;
    end
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ps_cnt   <= '0;
        end else begin
            if (enable) begin
                if (ps_cnt == step_limit) begin
                    ps_cnt <= '0;
                end else begin
                    ps_cnt <= ps_cnt + 4'd1;
                end
            end
        end
    end
    assign step_now = enable && (ps_cnt == step_limit);
    always_comb begin
        count_d = count_q;
        will_overflow  = (count_q == max_val) && do_inc && step_now;
        will_underflow = (count_q == min_val) && do_dec && step_now;
        wrap_around    = 1'b0;
        if (load_en) begin
            count_d = load_data;
        end else if (step_now) begin
            if (do_inc && !do_dec) begin
                if (will_overflow) begin
                    if (SATURATE) begin
                        count_d = max_val;
                    end else begin
                        count_d = '0;
                        wrap_around = 1'b1;
                    end
                end else begin
                    count_d = count_q + inc_one;
                end
            end else if (do_dec && !do_inc) begin
                if (will_underflow) begin
                    if (SATURATE) begin
                        count_d = min_val;
                    end else begin
                        count_d = max_val;
                        wrap_around = 1'b1;
                    end
                end else begin
                    count_d = count_q - 1'b1;
                end
            end
        end
    end
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_q  <= '0;
        end else begin
            count_q  <= count_d;
        end
    end
    assign count    = count_q;
    assign at_zero  = (count_q == min_val);
    assign at_max   = (count_q == max_val);
    assign overflow = wrap_around;
    assign dbg_shadow = count_q;
    assign stretch_amt_ext = {enable, up, load_en, count_q[0], count_q[1]};
    logic stretched_gate;
    pulse_stretcher #(.N(4)) u_ps (
        .clk       (clk),
        .rst_n     (rst_n),
        .en        (enable),
        .amount    (stretch_amt_ext),
        .in_pulse  (step_now),
        .out_pulse (stretched_gate)
    );
    always_comb begin
        if (stretched_gate) begin
            if (do_inc && !do_dec) begin
                if (!SATURATE && (count_q == max_val)) begin
                    count_d = '0;
                end
            end
        end
    end
endmodule