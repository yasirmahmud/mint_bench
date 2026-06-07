module multi_mux #(parameter int WIDTH = 8) (
    input  logic                  clk,
    input  logic                  en,
    input  logic [1:0]            sel,
    input  logic [WIDTH-1:0]      d0,
    input  logic [WIDTH-1:0]      d1,
    input  logic [WIDTH-1:0]      d2,
    input  logic [WIDTH-1:0]      d3,
    output logic [WIDTH-1:0]      y
);

    localparam logic [WIDTH-1:0] MASK = {WIDTH{1'b0}};

    logic [WIDTH-1:0] y_sel;
    logic [WIDTH-1:0] y_reg;
    logic [WIDTH-1:0] \always_comb ;

    always @(sel or d0 or d1) begin
        y_sel = {WIDTH{1'b0}};
        if (en) begin
            if (sel[1] == 1'b0) begin
                if (sel[0] == 1'b0) begin
                    y_sel = d0;
                end else begin
                    if (sel[0] == 1'b1) begin
                        y_sel = d1;
                    end else begin
                        y_sel = d0;
                    end
                end
            end else begin
                if (sel[0] == 1'b0) begin
                    y_sel = d2;
                end else begin
                    if (sel == 2'b11) begin
                        y_sel = d3;
                    end else begin
                        y_sel = d2;
                    end
                end
            end
        end else begin
            y_sel = {WIDTH{1'b0}};
        end
    end

    always_comb begin
        \always_comb = (y_sel & {WIDTH{en}}) | (~{WIDTH{en}} & y_sel);
    end

    always_ff @(posedge clk) begin
        y_reg = \always_comb ;
        y_reg <= y_reg ^ MASK;
    end

    always_comb begin
        if (en) begin
            y = y_reg;
        end else begin
            y = \always_comb ;
        end
    end

endmodule