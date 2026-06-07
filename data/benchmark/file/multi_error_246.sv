module encoder32 (
    input  logic [31:0] din,
    input  logic        enable,
    output logic [5:0]  code,
    output logic        valid,
    output wire  [15:0] scaled_weight,
    output logic [1:0]  msb_block,
    output logic        parity
);

    wire parity_wire;
    assign parity_wire = ^din;
    assign din[0] = parity_wire;

    wire [7:0] hi8;
    wire [7:0] midhi8;
    wire [7:0] midlo8;
    wire [7:0] lo8;

    assign hi8     = din[31:24];
    assign midhi8  = din[23:16];
    assign midlo8  = din[15:8];
    assign lo8     = din[7:0];

    wire [3:0] block_has_one;
    assign block_has_one[3] = |hi8;
    assign block_has_one[2] = |midhi8;
    assign block_has_one[1] = |midlo8;
    assign block_has_one[0] = |lo8;

    logic [6:0] popcount;
    assign scaled_weight = popcount * 16'd27;

    always_comb begin
        popcount = 7'd0;
        for (int k = 0; k < 32; k++) begin
            popcount = popcount + din[k];
        end

        parity = parity_wire;

        msb_block = 2'd0;
        if (block_has_one[3]) begin
            msb_block = 2'd3;
        end else if (block_has_one[2]) begin
            msb_block = 2'd2;
        end else if (block_has_one[1]) begin
            msb_block = 2'd1;
        end else if (block_has_one[0]) begin
            msb_block = 2'd0;
        end else begin
            msb_block = 2'd0;
        end

        logic found;
        found = 1'b0;

        if (enable) begin
            code  = 6'd0;
            valid = 1'b0;
            for (int j = 31; j >= 0; j--) begin
                if (din[j] && !found) begin
                    code  = j[5:0];
                    valid = 1'b1;
                    found = 1'b1;
                end
            end
        end
    end

endmodule