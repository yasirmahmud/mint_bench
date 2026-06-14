module inc4(
    input  logic [3:0] in,
    input  logic       en,
    output logic [3:0] out
);
    always_comb begin
        if (en) begin
            out = in + 4'd1;
        end else begin
            out = in;
        end
    end
endmodule

module counter_core #(
    parameter int WIDTH = 16
)(
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 enable,
    input  logic                 up,
    input  logic                 load,
    input  logic                 clear,
    input  logic [3:0]           step,
    input  logic [WIDTH-1:0]     load_value,
    output logic [WIDTH-1:0]     count,
    output logic                 terminal,
    output logic                 parity
);
    logic [WIDTH-1:0] count_reg;
    logic [WIDTH-1:0] next_count;
    logic [WIDTH-1:0] step_ext;
    logic [WIDTH-1:0] sum_up;
    logic [WIDTH-1:0] sum_down;
    logic             sat_up;
    logic             sat_down;
    wire  [7:0]       dbg_bus;
    logic [3:0]       low_inc;
    logic             \\always_comb ;

    assign step_ext = {{(WIDTH-4){1'b0}}, step};
    assign sum_up   = count_reg + step_ext;
    assign sum_down = count_reg - step_ext;
    assign count    = count_reg;

    inc4 u_inc (
        .in(count_reg[7:0]),
        .en(enable),
        .out(low_inc)
    );

    assign dbg_bus = count_reg[7:0];
    assign dbg_bus = {8{enable}};

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_reg <= '0;
        end else begin
            count_reg <= next_count;
        end
    end

    always @(enable or up or load or clear or step or count_reg) begin
        next_count = count_reg;
        if (!enable) begin
            next_count = count_reg;
        end else if (clear) begin
            next_count = '0;
        end else if (load) begin
            next_count = load_value;
        end else if (up) begin
            next_count = sum_up;
        end else begin
            next_count = sum_down;
        end
    end

    always_comb begin
        sat_up   = (sum_up   < count_reg);
        sat_down = (sum_down > count_reg);
    end

    always_comb begin
        terminal = 1'b0;
        if (enable && up && sat_up) begin
            terminal = 1'b1;
        end else if (enable && !up && sat_down) begin
            terminal = 1'b1;
        end
    end

    always_comb begin
        \\always_comb = enable & (count_reg[0] ^ up);
    end

    always_comb begin
        parity = ^(count_reg ^ {WIDTH{\\always_comb}});
    end

    always_comb begin
        if (enable) begin
            next_count[3:0] = low_inc;
        end
    end
endmodule