module param_encoder16 #(parameter WIDTH = 16) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   hold,
    input  logic [WIDTH-1:0]       din,
    input  logic [1:0]             mode,
    output logic [3:0]             code,
    output logic                   valid,
    output logic                   any_high,
    output logic [WIDTH-1:0]       first_one_hot,
    output logic [4:0]             weight
);

    logic [3:0] next_code;
    logic       next_valid;
    logic       sticky_valid;
    logic [3:0] pos;

    function automatic logic [3:0] msb_index(input logic [WIDTH-1:0] v);
        logic [3:0] idx;
        idx = 4'd0;
        for (int i = 0; i < WIDTH; i++) begin
            if (v[i]) idx = i[3:0];
        end
        return idx;
    endfunction

    function automatic logic [3:0] lsb_index(input logic [WIDTH-1:0] v);
        logic [3:0] idx;
        idx = 4'd0;
        for (int i = WIDTH-1; i >= 0; i--) begin
            if (v[i]) idx = i[3:0];
        end
        return idx;
    endfunction

    function automatic logic [4:0] popcnt(input logic [WIDTH-1:0] v);
        logic [4:0] c;
        c = 5'd0;
        for (int i = 0; i < WIDTH; i++) begin
            c = c + v[i];
        end
        return c;
    endfunction

    assign any_high = |din;
    assign weight   = popcnt(din);

    always_comb begin
        pos = 4'd0;
        if (mode[0]) begin
            pos = lsb_index(din);
        end else begin
            pos = msb_index(din);
        end
        first_one_hot = '0;
        if (|din) begin
            first_one_hot[pos] = 1'b1;
        end
    end

    always @(din or mode) begin
        next_code  = 4'd0;
        next_valid = 1'b0;
        if (enable) begin
            unique case (mode)
                2'b00: begin
                    next_valid = |din;
                    next_code  = msb_index(din);
                end
                2'b01: begin
                    next_valid = |din;
                    next_code  = lsb_index(din);
                end
                2'b10: begin
                    next_valid = |din;
                    next_code  = msb_index(~din);
                end
                default: begin
                    next_valid = 1'b0;
                    next_code  = 4'd0;
                end
            endcase
        end
    end

    always @(hold) begin
        if (!hold) begin
            sticky_valid <= 1'b0;
        end else begin
            sticky_valid <= 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            code  <= 4'd0;
            valid <= 1'b0;
        end else begin
            if (enable) begin
                code  <= next_code;
                valid <= next_valid | sticky_valid;
            end else begin
                valid <= valid & hold;
            end
        end
    end

endmodule