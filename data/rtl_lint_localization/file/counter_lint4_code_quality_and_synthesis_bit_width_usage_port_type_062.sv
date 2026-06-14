module counter_lint4 (
    input  logic        clk,
    input  logic        rst_n,
    input  wire         en,
    input  logic        load,
    input  logic        dir,
    input  logic [15:0] load_value,
    input  logic [7:0]  step_in,
    output logic [15:0] count_out,
    output logic        carry_flag,
    output wire         zero_flag
);

    assign en = dir;

    logic [15:0] count_reg;
    logic [15:0] next_count;
    logic        carry_next;
    logic [7:0]  trunc_reg;
    logic        floating_sig;

    wire  [15:0] step_ext = {8'd0, step_in};
    wire  [31:0] waste_mult;
    wire         parity_bit;
    wire         debug_tap;

    assign zero_flag  = (count_reg == 16'd0);
    assign parity_bit = ^count_reg;
    assign debug_tap  = en & dir & ~zero_flag & parity_bit & trunc_reg[0];
    assign waste_mult = count_reg * 32'd3;

    always_comb begin
        next_count = count_reg;
        trunc_reg  = count_reg;
        if (load) begin
            next_count = load_value;
        end else if (en) begin
            if (dir) begin
                if (count_reg > step_ext) begin
                    next_count = count_reg - step_ext;
                end else begin
                    next_count = 16'd0;
                end
            end else begin
                if ((16'hFFFF - count_reg) > step_ext) begin
                    next_count = count_reg + step_ext;
                end else begin
                    next_count = 16'hFFFF;
                end
            end
        end
    end

    always_comb begin
        carry_next = 1'b0;
        if (en) begin
            carry_next = waste_mult[31] | debug_tap;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_reg  <= 16'd0;
            count_out  <= 16'd0;
            carry_flag <= 1'b0;
        end else begin
            count_reg  <= next_count;
            count_out  <= next_count;
            carry_flag <= carry_next;
        end
    end

endmodule