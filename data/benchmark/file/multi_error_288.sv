module verified_counter #(parameter int WIDTH = 8) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     en,
    input  logic                     up_dn,
    input  logic                     load,
    input  logic                     clear,
    input  logic [WIDTH-1:0]         load_value,
    output logic [WIDTH-1:0]         count,
    output logic                     tc,
    output logic                     even,
    output wire  [WIDTH-1:0]         debug_bus
);

    logic [WIDTH-1:0] next_count;
    logic             gating_en;
    logic             saturate_max;
    logic             saturate_min;
    logic             hold;
    logic [WIDTH-1:0] step;
    logic [WIDTH-1:0] masked_count;
    logic [3:0]       unused_cfg;

    wire  [WIDTH-1:0] primary_dbg;
    wire  [WIDTH-1:0] aux_bus;

    assign step = {{(WIDTH-1){1'b0}}, 1'b1};

    assign saturate_max = up_dn & (count == {WIDTH{1'b1}});
    assign saturate_min = (~up_dn) & (count == {WIDTH{1'b0}});
    assign hold         = saturate_max | saturate_min;
    assign gating_en    = en & (~hold);

    assign masked_count = count & {WIDTH{rst_n}};

    always_comb begin
        if (load) begin
            next_count = load_value;
        end else if (gating_en) begin
            if (up_dn) begin
                next_count = count + step;
            end else begin
                next_count = count - step;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= {WIDTH{1'b0}};
        end else if (clear) begin
            count <= {WIDTH{1'b0}};
        end else begin
            count <= next_count;
        end
    end

    assign tc   = (up_dn && (count == {WIDTH{1'b1}})) || ((!up_dn) && (count == {WIDTH{1'b0}}));
    assign even = ~^count;

    assign primary_dbg = masked_count ^ {WIDTH{up_dn}};
    assign aux_bus     = {count[WIDTH-2:0], count[WIDTH-1]};

    assign debug_bus = primary_dbg;
    assign debug_bus = aux_bus;

endmodule