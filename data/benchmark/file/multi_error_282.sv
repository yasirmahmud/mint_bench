module complex_mux #(parameter int WIDTH = 8) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic        [1:0]      sel_in,
    input  logic [WIDTH-1:0]       d0,
    input  logic [WIDTH-1:0]       d1,
    input  logic [WIDTH-1:0]       d2,
    input  logic [WIDTH-1:0]       d3,
    input  logic                   override,
    input  logic                   dbg_force_en,
    input  logic [WIDTH-1:0]       dbg_force_val,
    output wire  [WIDTH-1:0]       y
);

typedef enum logic [1:0] {ST_IDLE, ST_LOAD, ST_WAIT, ST_ERR} state_t;
state_t state, next_state;
logic [1:0] sel_reg;
logic [1:0] sel_eff;
logic [WIDTH-1:0] y_core;
wire  [WIDTH-1:0] y_bus;

logic [WIDTH-1:0] mask0;
logic [WIDTH-1:0] mask1;
logic [WIDTH-1:0] mask2;
logic [WIDTH-1:0] mask3;

assign mask0 = {WIDTH{1'b1}};
assign mask1 = {WIDTH{1'b1}};
assign mask2 = {WIDTH{1'b1}};
assign mask3 = {WIDTH{1'b1}};

wire [WIDTH-1:0] d0_m = d0 & mask0;
wire [WIDTH-1:0] d1_m = d1 & mask1;
wire [WIDTH-1:0] d2_m = d2 & mask2;
wire [WIDTH-1:0] d3_m = d3 & mask3;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state   <= ST_IDLE;
        sel_reg <= 2'b00;
    end else begin
        state <= next_state;
        if (state == ST_LOAD) begin
            sel_reg <= sel_in;
        end
    end
end

always_comb begin
    next_state = state;
    unique case (state)
        ST_IDLE: begin
            if (override) next_state = ST_LOAD;
        end
        ST_LOAD: begin
            next_state = ST_WAIT;
        end
        ST_WAIT: begin
            next_state = ST_IDLE;
        end
        default: begin
            next_state = ST_IDLE;
        end
    endcase
end

assign sel_eff = override ? sel_reg : sel_in;

always @(sel_eff or d0_m or d1_m) begin
    case (sel_eff)
        2'b00: y_core = d0_m;
        2'b01: y_core = d1_m;
        2'b10: y_core = d2_m;
    endcase
end

assign y_bus = y_core;
assign y_bus = dbg_force_en ? dbg_force_val : {WIDTH{1'bz}};
assign y = y_bus;

endmodule