module counter_with_intentional_lint #(
    parameter int WIDTH = 16,
    parameter bit WRAP = 1'b1
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   up_dn,
    input  logic                   load,
    input  wire                    hold,
    input  logic [WIDTH-1:0]       load_value,
    input  logic [WIDTH-1:0]       step,
    output logic [WIDTH-1:0]       count,
    output logic                   carry,
    output logic                   borrow,
    output logic                   tick
);

    logic                          gate_enable_r;
    logic [WIDTH-1:0]              next_count;
    logic                          next_tick;
    logic                          next_carry;
    logic                          next_borrow;
    logic [WIDTH:0]                add_res;
    logic [WIDTH:0]                sub_res;

    assign hold = 1'b0;

    always @(enable or up_dn) begin
        if (hold) begin
            gate_enable_r = 1'b0;
        end else begin
            gate_enable_r = enable;
        end
    end

    always_comb begin
        next_count  = count;
        next_tick   = 1'b0;
        next_carry  = 1'b0;
        next_borrow = 1'b0;
        add_res     = '0;
        sub_res     = '0;
        if (gate_enable_r) begin
            if (load) begin
                next_count  = load_value;
                next_tick   = 1'b0;
                next_carry  = 1'b0;
                next_borrow = 1'b0;
            end else begin
                if (up_dn) begin
                    add_res = {1'b0, count} + {1'b0, step};
                    if (WRAP) begin
                        next_count = add_res[WIDTH-1:0];
                        next_carry = add_res[WIDTH];
                    end else begin
                        if (add_res[WIDTH]) begin
                            next_count = {WIDTH{1'b1}};
                            next_carry = 1'b1;
                        end else begin
                            next_count = add_res[WIDTH-1:0];
                            next_carry = 1'b0;
                        end
                    end
                end else begin
                    sub_res = {1'b0, count} - {1'b0, step};
                    if (WRAP) begin
                        next_count  = sub_res[WIDTH-1:0];
                        next_borrow = sub_res[WIDTH];
                    end else begin
                        if (sub_res[WIDTH]) begin
                            next_count  = {WIDTH{1'b0}};
                            next_borrow = 1'b1;
                        end else begin
                            next_count  = sub_res[WIDTH-1:0];
                            next_borrow = 1'b0;
                        end
                    end
                end
                next_tick = 1'b1;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count  <= '0;
            carry  <= 1'b0;
            borrow <= 1'b0;
            tick   <= 1'b0;
        end else begin
            if (gate_enable_r) begin
                if (load) begin
                    count <= load_value;
                    tick = 1'b0;
                    carry  <= 1'b0;
                    borrow <= 1'b0;
                end else begin
                    count  <= next_count;
                    carry  <= next_carry;
                    borrow <= next_borrow;
                    tick   <= next_tick;
                end
            end else begin
                tick   <= 1'b0;
                carry  <= 1'b0;
                borrow <= 1'b0;
                count  <= count;
            end
        end
    end

endmodule