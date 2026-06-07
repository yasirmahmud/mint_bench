module mux8 #(parameter int W = 16)
(
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic [W-1:0]         in0,
    input  logic [W-1:0]         in1,
    input  logic [W-1:0]         in2,
    input  logic [W-1:0]         in3,
    input  logic [W-1:0]         in4,
    input  logic [W-1:0]         in5,
    input  logic [W-1:0]         in6,
    input  logic [W-1:0]         in7,
    input  logic [2:0]           sel,
    output logic [W-1:0]         y,
    output logic                 y_changed,
    output logic [31:0]          activity_count
);

    logic [W-1:0] in_bus [0:7];
    logic [W-1:0] y_q;
    logic         y_changed_r;
    logic [31:0]  activity_count_r;

    always_comb begin
        in_bus[0] = in0;
        in_bus[1] = in1;
        in_bus[2] = in2;
        in_bus[3] = in3;
        in_bus[4] = in4;
        in_bus[5] = in5;
        in_bus[6] = in6;
        in_bus[7] = in7;
    end

    always_comb begin
        case (sel)
            3'd0: y = in_bus[0];
            3'd1: y = in_bus[1];
            3'd2: y = in_bus[2];
            3'd3: y = in_bus[3];
            3'd4: y = in_bus[4];
            3'd5: y = in_bus[5];
            3'd6: y = in_bus[6];
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            y_q <= '0;
            y_changed_r <= 1'b0;
        end else begin
            y_changed_r <= (y != y_q);
            y_q <= y;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            activity_count_r <= 32'd0;
        end else begin
            if (y_changed_r) begin
                activity_count_r <= activity_count_r + 32'd1;
            end
        end
    end

    assign activity_count = activity_count_r;

    assign y_changed = y_changed_r

endmodule