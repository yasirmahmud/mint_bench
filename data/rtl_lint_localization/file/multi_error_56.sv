module add8(
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] y
);
    assign y = a + b;
endmodule

module counter8(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        enable,
    input  logic        load,
    input  logic [7:0]  load_value,
    input  logic        up,
    input  logic [3:0]  step_cfg,
    input  logic        saturate,
    input  logic        clear,
    output logic [7:0]  count,
    output logic        carry,
    output logic        zero,
    output logic        at_max
);
    localparam logic [7:0] MAX_VALUE = 8'hFF;
    logic [7:0] count_q;
    logic [7:0] count_d;
    logic [7:0] sum_up;
    logic [7:0] sum_down;
    logic [7:0] step_ext;
    logic        will_carry_up;
    logic        will_underflow_down;
    logic        step_is_zero;
    logic [7:0] boundary_up_value;
    logic [7:0] boundary_down_value;
    logic        op_is_up;
    logic        do_saturate;
    logic        do_enable;
    logic        do_load;
    logic        do_clear;
    logic        take_step;
    logic        take_down;
    logic        take_up;
    logic        next_carry_flag;
    logic        prev_carry_flag;
    logic        guard_valid;
    logic        guard_enable;
    logic        guard_path;
    logic        reserved_spare;

    assign step_ext = {4'b0000, step_cfg};
    assign sum_down = count_q - step_ext;
    assign zero     = (count_q == 8'd0);
    assign at_max   = (count_q == MAX_VALUE);
    assign boundary_up_value   = MAX_VALUE;
    assign boundary_down_value = 8'd0;
    assign do_enable = enable;
    assign do_load   = load;
    assign do_clear  = clear;
    assign do_saturate = saturate;
    assign op_is_up  = up;
    assign step_is_zero = (step_ext == 8'd0);
    assign take_step = do_enable & ~step_is_zero;
    assign take_up   = take_step & op_is_up;
    assign take_down = take_step & ~op_is_up;
    assign guard_enable = do_enable | do_load | do_clear;
    assign guard_valid  = guard_enable;
    assign guard_path   = guard_valid;

    add8 u_add(.a(count_q), .b(step_cfg), .y(sum_up));

    always_comb begin
        count_d = count_q;
        next_carry_flag = 1'b0;
        if (do_clear) begin
            count_d = 8'd0;
            next_carry_flag = 1'b0;
        end else if (do_load) begin
            count_d = load_value;
            next_carry_flag = 1'b0;
        end else if (take_up) begin
            if (do_saturate) begin
                if (((count_q + step_ext) < count_q)) begin
                    count_d = boundary_up_value;
                    next_carry_flag = 1'b1;
                end else begin
                    count_d = sum_up;
                    next_carry_flag = 1'b0;
                end
            end else begin
                count_d = sum_up;
                next_carry_flag = (((count_q + step_ext) < count_q)) ? 1'b1 : 1'b0;
            end
        end else if (take_down) begin
            if (do_saturate) begin
                if (count_q < step_ext) begin
                    count_d = boundary_down_value;
                    next_carry_flag = 1'b1;
                end else begin
                    count_d = sum_down;
                    next_carry_flag = 1'b0;
                end
            end else begin
                count_d = sum_down;
                next_carry_flag = (count_q < step_ext) ? 1'b1 : 1'b0;
            end
        end else begin
            count_d = count_q;
            next_carry_flag = 1'b0;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_q <= 8'd0;
            carry   <= 1'b0;
            prev_carry_flag <= 1'b0;
        end else begin
            if (guard_path) begin
                count_q <= count_d;
                carry   <= next_carry_flag;
                prev_carry_flag <= next_carry_flag;
            end else begin
                count_q <= count_q;
                carry   <= 1'b0;
                prev_carry_flag <= prev_carry_flag;
            end
        end
    end

    assign count = count_q;
endmodule