module counter_with_intentional_lint #(parameter int WIDTH = 16) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     enable,
    input  logic                     dir_up,
    input  logic                     load,
    input  logic                     saturate,
    input  logic [WIDTH-1:0]         load_value,
    input  logic [WIDTH-1:0]         step,
    input  logic [WIDTH-1:0]         max_value,
    input  logic [WIDTH-1:0]         min_value,
    input  logic [WIDTH-1:0]         hold_mask,
    output logic [WIDTH-1:0]         count,
    output logic                     carry_out,
    output logic                     borrow_out,
    output logic                     at_max,
    output logic                     at_min
);

    logic [WIDTH-1:0] cnt;
    logic [WIDTH-1:0] next_cnt;
    logic              carry_next;
    logic              borrow_next;
    logic              gate_enable;

    logic [WIDTH+8-1:0] scaled_step;
    logic [WIDTH-1:0]   step_eff;

    assign scaled_step = step * 8'd256;
    assign step_eff    = scaled_step[WIDTH+7:8];

    logic [WIDTH:0] add_ext;
    logic [WIDTH:0] sub_ext;

    assign add_ext = {1'b0, cnt} + {1'b0, step_eff};
    assign sub_ext = {1'b0, cnt} - {1'b0, step_eff};

    logic [WIDTH-1:0] candidate_up;
    logic [WIDTH-1:0] candidate_down;

    always_comb begin
        candidate_up   = add_ext[WIDTH-1:0];
        candidate_down = sub_ext[WIDTH-1:0];
        if (saturate) begin
            if (add_ext[WIDTH] || (add_ext[WIDTH-1:0] > max_value)) begin
                candidate_up = max_value;
            end
            if (sub_ext[WIDTH] || (sub_ext[WIDTH-1:0] < min_value)) begin
                candidate_down = min_value;
            end
        end
    end

    logic [WIDTH-1:0] next_raw;

    always_comb begin
        next_raw = cnt;
        if (load) begin
            next_raw = load_value;
        end else if (dir_up) begin
            next_raw = candidate_up;
        end else begin
            next_raw = candidate_down;
        end
    end

    logic [WIDTH-1:0] next_masked;

    always_comb begin
        for (int i = 0; i < WIDTH; i++) begin
            if (hold_mask[i]) begin
                next_masked[i] = cnt[i];
            end else begin
                next_masked[i] = next_raw[i];
            end
        end
    end

    always @(enable or load) begin
        if (load) begin
            gate_enable = 1'b1;
        end else begin
            gate_enable = enable & dir_up;
        end
    end

    always_comb begin
        carry_next  = 1'b0;
        borrow_next = 1'b0;
        if (gate_enable) begin
            next_cnt    = next_masked;
            carry_next  = dir_up  & add_ext[WIDTH];
            borrow_next = (~dir_up) & sub_ext[WIDTH];
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt        <= '0;
            carry_out  <= 1'b0;
            borrow_out <= 1'b0;
        end else begin
            cnt        <= next_cnt;
            carry_out  <= carry_next;
            borrow_out <= borrow_next;
        end
    end

    assign count  = cnt;
    assign at_max = (cnt == max_value);
    assign at_min = (cnt == min_value);

endmodule