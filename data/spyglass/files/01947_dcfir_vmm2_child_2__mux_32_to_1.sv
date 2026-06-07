// Helper module definition for mux_32_to_1
module mux_32_to_1 (
    input clk, // Unused, but kept for interface compatibility
    input [15:0] din_0, din_1, din_2, din_3,
                 din_4, din_5, din_6, din_7,
                 din_8, din_9, din_10, din_11,
                 din_12, din_13, din_14, din_15,
                 din_16, din_17, din_18, din_19,
                 din_20, din_21, din_22, din_23,
                 din_24, din_25, din_26, din_27,
                 din_28, din_29, din_30, din_31,
    input [5:0] sel,
    output [15:0] mux_out
);

reg [15:0] mux_out_reg;

always @(*) begin
    case (sel)
        6'd0:  mux_out_reg = din_0;
        6'd1:  mux_out_reg = din_1;
        6'd2:  mux_out_reg = din_2;
        6'd3:  mux_out_reg = din_3;
        6'd4:  mux_out_reg = din_4;
        6'd5:  mux_out_reg = din_5;
        6'd6:  mux_out_reg = din_6;
        6'd7:  mux_out_reg = din_7;
        6'd8:  mux_out_reg = din_8;
        6'd9:  mux_out_reg = din_9;
        6'd10: mux_out_reg = din_10;
        6'd11: mux_out_reg = din_11;
        6'd12: mux_out_reg = din_12;
        6'd13: mux_out_reg = din_13;
        6'd14: mux_out_reg = din_14;
        6'd15: mux_out_reg = din_15;
        6'd16: mux_out_reg = din_16;
        6'd17: mux_out_reg = din_17;
        6'd18: mux_out_reg = din_18;
        6'd19: mux_out_reg = din_19;
        6'd20: mux_out_reg = din_20;
        6'd21: mux_out_reg = din_21;
        6'd22: mux_out_reg = din_22;
        6'd23: mux_out_reg = din_23;
        6'd24: mux_out_reg = din_24;
        6'd25: mux_out_reg = din_25;
        6'd26: mux_out_reg = din_26;
        6'd27: mux_out_reg = din_27;
        6'd28: mux_out_reg = din_28;
        6'd29: mux_out_reg = din_29;
        6'd30: mux_out_reg = din_30;
        6'd31: mux_out_reg = din_31;
        default: mux_out_reg = 16'd0;
    endcase
end

assign mux_out = mux_out_reg;

endmodule
