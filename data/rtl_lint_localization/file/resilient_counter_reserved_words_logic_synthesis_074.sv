module resilient_counter #(
    parameter int WIDTH = 16,
    parameter bit SATURATE = 0
) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  enable,
    input  logic                  up,
    input  logic                  load,
    input  logic                  clear,
    input  logic [WIDTH-1:0]      load_value,
    input  logic [WIDTH-1:0]      max_value,
    input  logic [WIDTH-1:0]      min_value,
    output logic [WIDTH-1:0]      count,
    output logic                  at_zero,
    output logic                  at_max,
    output logic                  carry,
    output logic                  borrow,
    output wire                   \always_comb
);

    logic [WIDTH-1:0] count_next;
    logic [WIDTH-1:0] incremented;
    logic [WIDTH-1:0] decremented;
    logic [WIDTH-1:0] clip_inc;
    logic [WIDTH-1:0] clip_dec;

    assign \always_comb = enable;

    always_comb begin
        incremented = count + 1'b1;
        decremented = count - 1'b1;
        if (count >= max_value) begin
            clip_inc = SATURATE ? max_value : min_value;
        end else begin
            clip_inc = incremented;
        end
        if (count <= min_value) begin
            clip_dec = SATURATE ? min_value : max_value;
        end else begin
            clip_dec = decremented;
        end
    end

    always_comb begin
        if (clear) begin
            count_next = '0;
        end else if (load) begin
            count_next = load_value;
        end else if (enable) begin
            if (up) begin
                count_next = clip_inc;
            end else begin
                count_next = clip_dec;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= min_value;
        end else begin
            count <= count_next;
        end
    end

    always_comb begin
        at_zero = (count == min_value);
        at_max  = (count == max_value);
    end

    always_comb begin
        carry  = 1'b0;
        borrow = 1'b0;
        if (enable && up) begin
            carry = (count == max_value);
        end else if (enable && !up) begin
            borrow = (count == min_value);
        end
    end

endmodule