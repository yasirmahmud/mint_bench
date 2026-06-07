module PE_3 ( clock , R , S1 , S2 , S1S2mux , newDist , Accumulate , Rpipe ) ;
input  clock ;
input  [7:0] R ;
input  [7:0] S1 ;
input  [7:0] S2 ;
input  S1S2mux ;
input  newDist ;
output reg [7:0] Accumulate ; // Accumulate is a registered output
output reg [7:0] Rpipe ;      // Rpipe is a registered output

wire [7:0] AccumulateIn ; // Input to the Accumulate register
wire [7:0] difference ;   // Result of R - S1S2_mux_out

// Internal wires to replace signals from black-box instances
wire [7:0] S1S2_mux_out; // Output of the S1/S2 multiplexer
wire Carry;              // Carry-out from the adder
wire [7:0] sum_N_bits;   // 8-bit sum result from the adder
wire n8;                 // Inverted newDist signal

// DFFX1_LVT instances for Accumulate and Rpipe are replaced
// with a single always @(posedge clock) block.
always @(posedge clock) begin
    Rpipe <= R; // Pipelined copy of R
    Accumulate <= AccumulateIn; // Accumulator updates with AccumulateIn
end

// INVX1_LVT U5 (Inverter for newDist)
assign n8 = ~newDist;

// AO22X1_LVT U16-U23 (8-bit 2-to-1 multiplexer for S1/S2)
// N8-N15 are now represented by S1S2_mux_out
assign S1S2_mux_out = S1S2mux ? S1 : S2;

// PE_3_DW01_sub_1 sub_50 (8-bit subtractor)
assign difference = R - S1S2_mux_out;

// PE_3_DW01_add_0 add_56 (8-bit adder with carry-out)
// This replaces the black-box adder and resolves the 'pin A[8] connected to supply' violation
// by using Verilog's built-in addition operator which correctly handles widths.
assign {Carry, sum_N_bits} = Accumulate + difference; // Performs 8-bit unsigned addition, generating a 9-bit result {carry, sum}

// AO221X1_LVT U7-U13, U15 logic for AccumulateIn
// The design description states "conditionally adds the resulting difference to an accumulator".
// This implies that if newDist is asserted, Accumulate is initialized with 'difference'.
// If newDist is deasserted, Accumulate accumulates by adding 'difference' to its current value.
// This interpretation resolves any ambiguity or potential logical error from a literal gate-level
// translation of AO221X1_LVT when 'newDist' is low, which might incorrectly OR the carry-out into sum bits.
assign AccumulateIn = newDist ? difference : sum_N_bits;

endmodule
