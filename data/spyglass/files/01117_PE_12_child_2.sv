module PE_12 ( clock , R , S1 , S2 , S1S2mux , newDist , Accumulate , Rpipe ) ;
input  clock ;
input  [7:0] R ;
input  [7:0] S1 ;
input  [7:0] S2 ;
input  S1S2mux ;
input  newDist ;
output [7:0] Accumulate ;
output [7:0] Rpipe ;

// Internal wires for the overall module's operation
wire [7:0] AccumulateIn ;
wire [7:0] difference ;

// Declaring previously undeclared internal wires based on their usage in the original netlist
wire n8;
wire Carry; // Carry-out from the adder
wire [7:0] sum_accumulator_diff; // Represents the 8-bit sum (N33 down to N26) of Accumulate + difference
wire [7:0] selected_S;           // Represents the 8-bit output (N15 down to N8) of the S1/S2 multiplexer

// === Black-box replacements and functional logic reconstruction ===

// Replace DFFX1_LVT instances with behavioral Verilog D-flip-flops
// Accumulate is registered from AccumulateIn
// Rpipe is registered from R
reg [7:0] Accumulate_reg_internal;
reg [7:0] Rpipe_reg_internal;

always @(posedge clock) begin
    Accumulate_reg_internal <= AccumulateIn;
    Rpipe_reg_internal <= R;
end

// Assign the internal register outputs to the module's output ports
assign Accumulate = Accumulate_reg_internal;
assign Rpipe = Rpipe_reg_internal;

// Replace INVX1_LVT instances (U5, U6) with assign statements
assign n8 = ~newDist;

// Replace AO22X1_LVT instances (U15-U22) with a multiplexer
// The original gates implement: Y = (A1 & A2) | (A3 & A4)
// Where A1 is S1[i], A2 is S1S2mux, A3 is S2[i], A4 is n9 (~S1S2mux)
// This translates to: selected_S[i] = (S1[i] & S1S2mux) | (S2[i] & ~S1S2mux);
// Which is a standard 2-to-1 multiplexer
assign selected_S = S1S2mux ? S1 : S2;

// Replace PE_12_DW01_sub_1 (subtractor) with an assign statement
// The subtractor performs: DIFF = A - B - CI (where CI is borrow-in)
// Given .A(R), .B(selected_S), .CI(1'b0), .DIFF(difference)
assign difference = R - selected_S;

// Replace PE_12_DW01_add_0 (adder) with an assign statement
// The adder takes 9-bit inputs A and B, and a 1-bit CI, producing a 9-bit SUM.
// A = {1'b0, Accumulate[7:0]}, B = {1'b0, difference[7:0]}, CI = 1'b0.
// SUM = {Carry, N33..N26}.
// N33 is the MSB (SUM[7]) of the 8-bit sum, N26 is LSB (SUM[0]).
wire [8:0] add_A_input_9bit = {1'b0, Accumulate}; // Resolves checkPinConnectedToSupply for A[8]
wire [8:0] add_B_input_9bit = {1'b0, difference};
wire [8:0] sum_full_9bit = add_A_input_9bit + add_B_input_9bit + 1'b0; // CI is 1'b0

assign Carry = sum_full_9bit[8];
assign sum_accumulator_diff = sum_full_9bit[7:0]; // The 8-bit sum excluding the carry-out

// Replace AO221X1_LVT instances (U7, U9-U14, U23) for AccumulateIn logic
// The original gates implement: Y = (A1 & A2) | (A3 & A4) | A5
// For each bit AccumulateIn[i]:
// A1 = sum_accumulator_diff[i], A2 = n8 (~newDist)
// A3 = difference[i], A4 = newDist
// A5 = n23 (Carry & n8)
// So, AccumulateIn[i] = (sum_accumulator_diff[i] & ~newDist) | (difference[i] & newDist) | (Carry & ~newDist)
// Which simplifies to: AccumulateIn[i] = (~newDist & (sum_accumulator_diff[i] | Carry)) | (newDist & difference[i])
// This logic means: if newDist is asserted, AccumulateIn takes 'difference'.
// If newDist is de-asserted, AccumulateIn takes (sum_accumulator_diff OR Carry) bitwise.
wire [7:0] sum_or_carry_when_newDist_low;
genvar j;
generate
    for (j=0; j<8; j=j+1) begin : gen_sum_or_carry
        assign sum_or_carry_when_newDist_low[j] = sum_accumulator_diff[j] | Carry;
    end
endgenerate

assign AccumulateIn = newDist ? difference : sum_or_carry_when_newDist_low;

endmodule
