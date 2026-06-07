module PE_14 ( clock , R , S1 , S2 , S1S2mux , newDist , Accumulate , Rpipe ) ;
input  clock ;
input  [7:0] R ;
input  [7:0] S1 ;
input  [7:0] S2 ;
input  S1S2mux ;
input  newDist ;
output reg [7:0] Accumulate ;
output reg [7:0] Rpipe ;

wire [7:0] AccumulateIn ;
wire [7:0] difference ;

// Internal wires replacing black-box components' outputs/internal nets
wire Carry;        // Carry out from the 8-bit adder
wire [7:0] sum_N_bits; // The 8-bit sum result (corresponds to N33 down to N26)

wire n8;           // Inverted newDist (output of INVX1_LVT U5)
wire n9;           // Inverted S1S2mux (output of INVX1_LVT U6)
wire n23;          // Result of Carry & n8 (output of AND2X1_LVT U14)

wire [7:0] selected_S; // The output of the S1/S2 multiplexer (corresponds to N15 down to N8)


// Replace PE_14_DW01_add_0 with an RTL adder
// The original instance mapped: 
//   .A ( { 1'b0 , Accumulate } )
//   .B ( { 1'b0 , difference } )
//   .CI ( 1'b0 ) (implicitly handled by plain '+' operator)
//   .SUM ( { Carry , N33 , N32 , N31 , N30 , N29 , N28 , N27 , N26 } )
assign {Carry, sum_N_bits} = {1'b0, Accumulate} + {1'b0, difference};

// Replace PE_14_DW01_sub_1 with an RTL subtractor
// The original instance mapped:
//   .A ( R )
//   .B ( selected_S ) (corresponds to { N15 , ... , N8 })
//   .CI ( 1'b0 ) (implicitly handled by plain '-' operator)
//   .DIFF ( difference )
assign difference = R - selected_S;

// Replace DFFX1_LVT instances for Accumulate and Rpipe with always_ff blocks
always_ff @(posedge clock) begin
    Accumulate <= AccumulateIn;
end

always_ff @(posedge clock) begin
    Rpipe <= R;
end

// Replace INVX1_LVT U5 and U6
assign n8 = ~newDist;
assign n9 = ~S1S2mux;

// Replace AND2X1_LVT U14
assign n23 = Carry & n8;

// Replace AO22X1_LVT U15-U22 (S1/S2 mux)
// The original gates implement: Y = (A1 & A2) | (A3 & A4)
// For U15-U22, this is: Y = (S1[i] & S1S2mux) | (S2[i] & n9) which is S1S2mux ? S1[i] : S2[i]
assign selected_S = S1S2mux ? S1 : S2;

// Replace AO221X1_LVT U7-U13, U23 (AccumulateIn logic)
// The original gates implement: Y = (A1 & A2) | (A3 & A4) | A5
// For AccumulateIn[i]: Y = (sum_N_bits[i] & n8) | (difference[i] & newDist) | n23
// Substituting n8 = ~newDist and n23 = Carry & n8 (or Carry & ~newDist):
// Y = (sum_N_bits[i] & ~newDist) | (difference[i] & newDist) | (Carry & ~newDist)
// This simplifies to: newDist ? difference[i] : (sum_N_bits[i] | Carry)
assign AccumulateIn = newDist ? difference : (sum_N_bits | {8{Carry}});

endmodule
