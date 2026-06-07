module sine_wave_generator(
    input [9:0] in,
    output reg [15:0] gen
);

// The original design used an 'initial' block to populate individual registers
// and then fed them to an undefined 'mux_16_64' module. This causes two issues:
// 1. 'mux_16_64' is a black-box, meaning its definition is missing.
// 2. The 'initial' block is ignored for synthesis, making the sine values unavailable.
//
// To fix this, we combine the lookup table and multiplexer functionality into
// a single synthesizable 'always_comb' block using a 'case' statement.
// This explicitly defines the combinational logic for the ROM and the multiplexer.
// The 'gen' output is declared as 'reg' because it is assigned within an 'always' block.

always_comb begin
    // Use the lower 6 bits of 'in' to address the 64 entries (0 to 63).
    // The higher bits of 'in' ([9:6]) are effectively ignored, matching the behavior
    // of a 64-input multiplexer driven by a 6-bit select signal.
    case (in[5:0])
        6'd0: gen = 1000; // Corresponds to original i1
        6'd1: gen = 1098;
        6'd2: gen = 1195;
        6'd3: gen = 1290;
        6'd4: gen = 1383;
        6'd5: gen = 1471;
        6'd6: gen = 1556;
        6'd7: gen = 1634;
        6'd8: gen = 1707;
        6'd9: gen = 1773;
        6'd10: gen = 1831;
        6'd11: gen = 1882;
        6'd12: gen = 1924;
        6'd13: gen = 1957;
        6'd14: gen = 1981;
        6'd15: gen = 1995;
        6'd16: gen = 2000;
        6'd17: gen = 1995;
        6'd18: gen = 1981;
        6'd19: gen = 1957;
        6'd20: gen = 1924;
        6'd21: gen = 1882;
        6'd22: gen = 1831;
        6'd23: gen = 1773;
        6'd24: gen = 1707;
        6'd25: gen = 1634;
        6'd26: gen = 1556;
        6'd27: gen = 1471;
        6'd28: gen = 1383;
        6'd29: gen = 1290;
        6'd30: gen = 1195;
        6'd31: gen = 1098;
        6'd32: gen = 1000;
        6'd33: gen = 902;
        6'd34: gen = 805;
        6'd35: gen = 710;
        6'd36: gen = 617;
        6'd37: gen = 529;
        6'd38: gen = 444;
        6'd39: gen = 366;
        6'd40: gen = 293;
        6'd41: gen = 227;
        6'd42: gen = 169;
        6'd43: gen = 118;
        6'd44: gen = 76;
        6'd45: gen = 43;
        6'd46: gen = 19;
        6'd47: gen = 5;
        6'd48: gen = 0;
        6'd49: gen = 5;
        6'd50: gen = 19;
        6'd51: gen = 43;
        6'd52: gen = 76;
        6'd53: gen = 118;
        6'd54: gen = 169;
        6'd55: gen = 227;
        6'd56: gen = 293;
        6'd57: gen = 366;
        6'd58: gen = 444;
        6'd59: gen = 529;
        6'd60: gen = 617;
        6'd61: gen = 710;
        6'd62: gen = 805;
        6'd63: gen = 902; // Corresponds to original i64
        default: gen = 16'bx; // Default assignment for synthesis safety. 
                             // For valid 6-bit input (0-63), this case is not reached.
    endcase
end

endmodule
