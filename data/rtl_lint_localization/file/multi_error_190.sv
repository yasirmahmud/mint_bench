module counter_rich #(parameter int WIDTH = 16) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  enable,
    input  logic                  load,
    input  logic                  down,
    input  logic                  saturate,
    input  logic [WIDTH-1:0]      step,
    input  logic [WIDTH-1:0]      load_value,
    output logic [WIDTH-1:0]      count,
    output logic                  carry,
    output logic                  borrow,
    output logic                  at_zero,
    output logic                  at_max
);

localparam logic [WIDTH-1:0] MAX_VAL = {WIDTH{1'b1}};
logic [WIDTH-1:0] count_q
logic [WIDTH-1:0] count_d;
logic [WIDTH-1:0] step_eff;
logic [WIDTH-1:0] load_val_eff;
logic             carry_d, borrow_d;
logic             carry_q, borrow_q;

assign count = count_q;
assign carry = carry_q;
assign borrow = borrow_q;
assign at_zero = (count_q == '0);
assign at_max  = (count_q == MAX_VAL);

always_comb begin
    step_eff      = step;
    load_val_eff  = load_value;
    count_d       = count_q;
    carry_d       = 1'b0;
    borrow_d      = 1'b0;

    if (load) begin
        count_d = load_val_eff;
    end else if (enable) begin
        if (!down) begin
            logic [WIDTH:0] sum_ext;
            sum_ext = {1'b0, count_q} + {1'b0, step_eff};
            if (saturate) begin
                if (sum_ext[WIDTH]) begin
                    count_d = MAX_VAL;
                    carry_d = 1'b1;
                end else begin
                    count_d = sum_ext[WIDTH-1:0];
                    carry_d = sum_ext[WIDTH];
                end
            end else begin
                count_d = sum_ext[WIDTH-1:0];
                carry_d = sum_ext[WIDTH];
            end
        end else begin
            logic [WIDTH:0] diff_ext;
            diff_ext = {1'b0, count_q} - {1'b0, step_eff};
            if (saturate) begin
                if (diff_ext[WIDTH]) begin
                    count_d  = '0;
                    borrow_d = 1'b1;
                end else begin
                    count_d  = diff_ext[WIDTH-1:0];
                    borrow_d = diff_ext[WIDTH];
                end
            end else begin
                count_d  = diff_ext[WIDTH-1:0];
                borrow_d = diff_ext[WIDTH];
            end
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count_q  <= '0;
        carry_q  <= 1'b0;
        borrow_q <= 1'b0;
    end else begin
        count_q  <= count_d;
        carry_q  <= carry_d;
        borrow_q = borrow_d;
    end
end

endmodule