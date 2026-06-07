module PE_2 ( clock , R , S1 , S2 , S1S2mux , newDist , Accumulate , Rpipe ) ;
input  clock ;
input  [7:0] R ;
input  [7:0] S1 ;
input  [7:0] S2 ;
input  S1S2mux ;
input  newDist ;
output reg [7:0] Accumulate ;
output reg [7:0] Rpipe ;

// Internal wires for combinational logic
wire [7:0] S_mux_out;       // Output of the S1/S2 multiplexer (replaces N8-N15)
wire [7:0] difference;
wire [7:0] AccumulateIn;    // Input to the Accumulate register

wire n9;                    // Output of INVX1_LVT U5 (~S1S2mux)
wire n8;                    // Output of INVX1_LVT U6 (~newDist)
wire n23;                   // Output of AND2X1_LVT U14

wire [8:0] sum_accum_diff_9bit; // 9-bit sum result from the adder
wire Carry;                 // Carry output from the 9-bit adder (replaces Carry)
wire [7:0] sum_result_bits; // 8-bit sum result from the adder (replaces N26-N33)

// Mux for S1/S2: selects S1 or S2 based on S1S2mux
// Replaces AO22X1_LVT instances U16-U23
// Logic: Y = (A1 & A2) | (A3 & A4) where A2 = S1S2mux, A4 = n9 (~S1S2mux)
// S_mux_out[i] = (S1[i] & S1S2mux) | (S2[i] & ~S1S2mux)
assign S_mux_out = S1S2mux ? S1 : S2;

// Subtractor: R - S_mux_out
// Replaces PE_2_DW01_sub_1 instance sub_50
assign difference = R - S_mux_out;

// Inverter for S1S2mux
// Replaces INVX1_LVT instance U5
assign n9 = ~S1S2mux;

// Inverter for newDist
// Replaces INVX1_LVT instance U6
assign n8 = ~newDist;

// 9-bit Adder: {0, Accumulate} + {0, difference}
// Replaces PE_2_DW01_add_0 instance add_56
assign sum_accum_diff_9bit = {1'b0, Accumulate} + {1'b0, difference};
assign Carry = sum_accum_diff_9bit[8];
assign sum_result_bits = sum_accum_diff_9bit[7:0]; // N33 is sum_result_bits[7], N26 is sum_result_bits[0]

// AND gate: Carry & n8
// Replaces AND2X1_LVT instance U14
assign n23 = Carry & n8;

// AccumulateIn logic: conditional update for Accumulate
// Replaces AO221X1_LVT instances U7-U13, U15
// Logic: Y = (A1 & A2) | (A3 & A4) | A5
// AccumulateIn[i] = (sum_result_bits[i] & n8) | (difference[i] & newDist) | n23
// Simplified: AccumulateIn[i] = (~newDist & (sum_result_bits[i] | Carry)) | (newDist & difference[i])
// This applies to all bits of AccumulateIn simultaneously:
assign AccumulateIn = (~newDist & (sum_result_bits | {8{Carry}})) | (newDist & difference);

// Sequential logic for Accumulate and Rpipe registers
// Replaces DFFX1_LVT instances for Accumulate_reg and Rpipe_reg
always @(posedge clock) begin
    Accumulate <= AccumulateIn;
    Rpipe <= R;
end

endmodule
