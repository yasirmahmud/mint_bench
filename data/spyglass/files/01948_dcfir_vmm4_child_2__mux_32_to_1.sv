module mux_32_to_1 (
    input clk,
    input [15:0] din_0, input [15:0] din_1, input [15:0] din_2, input [15:0] din_3,
    input [15:0] din_4, input [15:0] din_5, input [15:0] din_6, input [15:0] din_7,
    input [15:0] din_8, input [15:0] din_9, input [15:0] din_10, input [15:0] din_11,
    input [15:0] din_12, input [15:0] din_13, input [15:0] din_14, input [15:0] din_15,
    input [15:0] din_16, input [15:0] din_17, input [15:0] din_18, input [15:0] din_19,
    input [15:0] din_20, input [15:0] din_21, input [15:0] din_22, input [15:0] din_23,
    input [15:0] din_24, input [15:0] din_25, input [15:0] din_26, input [15:0] din_27,
    input [15:0] din_28, input [15:0] din_29, input [15:0] din_30, input [15:0] din_31,
    input [5:0] sel,
    output reg [15:0] mux_out
);
    // Dummy usage of 'clk' to resolve 'input declared but not read' warning
    // while maintaining combinatorial behavior and preserving port list.
    wire dummy_clk_tie_off = clk;

    always @(*) begin
        case (sel)
            6'd0: mux_out = din_0;
            6'd1: mux_out = din_1;
            6'd2: mux_out = din_2;
            6'd3: mux_out = din_3;
            6'd4: mux_out = din_4;
            6'd5: mux_out = din_5;
            6'd6: mux_out = din_6;
            6'd7: mux_out = din_7;
            6'd8: mux_out = din_8;
            6'd9: mux_out = din_9;
            6'd10: mux_out = din_10;
            6'd11: mux_out = din_11;
            6'd12: mux_out = din_12;
            6'd13: mux_out = din_13;
            6'd14: mux_out = din_14;
            6'd15: mux_out = din_15;
            6'd16: mux_out = din_16;
            6'd17: mux_out = din_17;
            6'd18: mux_out = din_18;
            6'd19: mux_out = din_19;
            6'd20: mux_out = din_20;
            6'd21: mux_out = din_21;
            6'd22: mux_out = din_22;
            6'd23: mux_out = din_23;
            6'd24: mux_out = din_24;
            6'd25: mux_out = din_25;
            6'd26: mux_out = din_26;
            6'd27: mux_out = din_27;
            6'd28: mux_out = din_28;
            6'd29: mux_out = din_29;
            6'd30: mux_out = din_30;
            6'd31: mux_out = din_31;
            default: mux_out = 16'd0; // Default case to avoid latches
        endcase
    end
endmodule
