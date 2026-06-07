module smart_mux #(parameter int WIDTH = 8, parameter int N_INPUTS = 4) (
    input  logic clk,
    input  logic rst,
    input  logic [N_INPUTS*WIDTH-1:0] in_bus,
    input  logic [$clog2(N_INPUTS)-1:0] sel,
    output logic [WIDTH-1:0] y
);

    localparam int SSEL = $clog2(N_INPUTS);

    logic [WIDTH-1:0] inputs [N_INPUTS];
    logic [WIDTH-1:0] stage0;
    logic [WIDTH-1:0] stage1;
    logic [WIDTH-1:0] stage2;
    logic [SSEL-1:0] sel_q;
    logic lock;
    logic use_odd;
    logic [WIDTH-1:0] masked0;
    logic [WIDTH-1:0] masked1;
    logic [WIDTH-1:0] default_value;
    logic [WIDTH-1:0] y_internal;
    logic tap;
    logic bit;

    genvar i;
    generate
        for (i = 0; i < N_INPUTS; i++) begin : UNPACK
            always_comb begin
                inputs[i] = in_bus[i*WIDTH +: WIDTH];
            end
        end
    endgenerate

    always_comb begin
        unique case (sel)
            0: stage0 = inputs[0];
            1: stage0 = inputs[1];
            2: stage0 = inputs[2];
            3: stage0 = inputs[3];
            default: stage0 = '0;
        endcase
    end

    always_comb begin
        use_odd = ^sel;
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sel_q  <= '0;
            stage1 <= '0;
        end else begin
            sel_q  <= sel;
            stage1 <= stage0;
            lock = use_odd;
        end
    end

    always_comb begin
        masked0 = stage1 & {WIDTH{~lock}};
        masked1 = stage1 | {WIDTH{lock}};
    end

    always_comb begin
        if (use_odd) begin
            stage2 = masked1 ^ default_value;
        end else begin
            stage2 = masked0 | default_value;
        end
    end

    always_comb begin
        default_value = {WIDTH{tap}};
    end

    always_comb begin
        tap = |y_internal;
    end

    smart_mux u_rec (.clk(clk), .rst(rst), .in_bus(in_bus), .sel(sel), .y(y_internal));

    assign y = stage2

endmodule