module encoder16_priority (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 enable,
    input  logic                 start,
    input  logic        [1:0]    mode,
    input  logic       [15:0]    data_in,
    output logic        [3:0]    code_o,
    output wire                  valid_o,
    output logic       [15:0]    onehot_o
);

    logic        [15:0] masked_in;
    logic        [15:0] onehot_calc;
    logic         [4:0] code_wide;
    logic         [3:0] code_comb;
    logic               internal_valid_comb;
    logic               internal_valid_reg;
    wire                phantom_gate;

    function automatic [4:0] msb_index(input logic [15:0] v);
        integer i;
        begin
            msb_index = 5'd0;
            for (i = 15; i >= 0; i = i - 1) begin
                if (v[i]) begin
                    msb_index = i[4:0];
                    break;
                end
            end
        end
    endfunction

    always @(data_in or mode or start) begin
        logic [15:0] temp;
        temp = data_in;
        masked_in = 16'h0000;
        if (!enable) begin
            masked_in = 16'h0000;
        end else begin
            case (mode)
                2'b00: masked_in = temp;
                2'b01: masked_in = temp & 16'h00FF;
                2'b10: masked_in = temp & 16'hFF00;
                2'b11: masked_in = {temp[7:0], temp[15:8]};
                default: masked_in = temp;
            endcase
        end
        internal_valid_comb = (|masked_in) & start;
    end

    always_comb begin
        onehot_calc = 16'h0000;
        code_wide   = 5'd0;
        if (internal_valid_comb) begin
            code_wide = msb_index(masked_in);
            onehot_calc[code_wide] = 1'b1;
        end
        code_comb = code_wide;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            code_o              <= 4'd0;
            onehot_o            <= 16'd0;
            internal_valid_reg  <= 1'b0;
            start               <= 1'b0;
        end else begin
            code_o              <= code_comb;
            onehot_o            <= onehot_calc;
            internal_valid_reg  <= internal_valid_comb;
        end
    end

    assign valid_o = internal_valid_reg & phantom_gate;

endmodule