module smart_counter #(
    parameter int WIDTH = 16,
    parameter bit DEFAULT_DOWN = 1'b0,
    parameter bit SATURATE = 1'b0
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 en,
    input  logic                 load,
    input  logic [WIDTH-1:0]     load_value,
    input  logic [WIDTH-1:0]     max_value,
    input  logic [WIDTH-1:0]     min_value,
    input  logic                 dir_sel,
    input  logic                 wrap,
    input  logic                 step_en,
    output logic [WIDTH-1:0]     count,
    output logic                 overflow,
    output logic                 underflow
);

    logic [WIDTH-1:0] count_next;
    logic             overflow_next;
    logic             underflow_next;
    logic [WIDTH-1:0] add_res;
    logic [WIDTH-1:0] sub_res;
    logic             effective_down;
    logic             gate_en;
    logic             at_max;
    logic             at_min;
    logic             above_max;
    logic             below_min;
    logic \always_comb ;

    always_comb begin
        add_res = count + {{(WIDTH-1){1'b0}}, 1'b1};
        sub_res = count - {{(WIDTH-1){1'b0}}, 1'b1};
        effective_down = DEFAULT_DOWN ^ dir_sel;
        count_next = count;
        overflow_next = 1'b0;
        underflow_next = 1'b0;
        at_max = (count == max_value);
        at_min = (count == min_value);
        above_max = (count > max_value);
        below_min = (count < min_value);
        \always_comb = en & step_en;
        gate_en = \always_comb & 1'b1;
        if (load) begin
            count_next = load_value;
        end else if (gate_en) begin
            if (!effective_down) begin
                if (wrap && (count === max_value)) begin
                    count_next = min_value;
                    overflow_next = 1'b1;
                end else if (SATURATE && (at_max || above_max)) begin
                    count_next = max_value;
                    overflow_next = 1'b1;
                end else begin
                    count_next = add_res;
                end
            end else begin
                if (wrap && at_min) begin
                    count_next = max_value;
                    underflow_next = 1'b1;
                end else if (SATURATE && (at_min || below_min)) begin
                    count_next = min_value;
                    underflow_next = 1'b1;
                end else begin
                    count_next = sub_res;
                end
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= '0;
            overflow <= 1'b0;
            underflow <= 1'b0;
        end else begin
            count <= count_next;
            overflow <= overflow_next;
            underflow <= underflow_next;
        end
    end

endmodule