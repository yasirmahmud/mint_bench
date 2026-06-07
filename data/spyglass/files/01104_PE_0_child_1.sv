module PE_0 ( clock , R , S1 , S2 , S1S2mux , newDist , Accumulate , Rpipe ) ;
input  clock ;
input  [7:0] R ;
input  [7:0] S1 ;
input  [7:0] S2 ;
input  S1S2mux ;
input  newDist ;
output reg [7:0] Accumulate ;
output reg [7:0] Rpipe ;

wire [7:0] S_muxed;
wire [7:0] difference;
wire [7:0] next_accum_value; // The 8-bit sum of current Accumulate and difference
wire carry;              // Carry out from the addition

// Mux for S input: Selects S1 or S2 based on S1S2mux.
// This replaces AO22X1_LVT instances U15-U22 and INVX1_LVT U6.
assign S_muxed = S1S2mux ? S1 : S2;

// Subtraction: difference = R - S_muxed.
// This replaces PE_0_DW01_sub_1 instance sub_50.
assign difference = R - S_muxed;

// Addition: next_accum_value = Accumulate + difference.
// This replaces PE_0_DW01_add_0 instance add_56.
// The {1'b0, ...} concatenation handles the 9-bit addition with zero-extension,
// which resolves the 'pin A[8] connected to supply signals' violation.
assign {carry, next_accum_value} = {1'b0, Accumulate} + {1'b0, difference};

// Register updates for Accumulate and Rpipe.
// The design description states: "updating registers on each clock cycle when a new distribution signal is active."
// This implies a synchronous enable for both registers.
// This replaces DFFX1_LVT instances for Accumulate and Rpipe, and the complex AO221X1_LVT/AND2X1_LVT logic
// used for AccumulateIn, which appeared to contradict the natural language description.
// The natural language description is prioritized for functional correctness.
always @(posedge clock) begin
    if (newDist) begin
        // "adds the result to the running accumulate value"
        Accumulate <= next_accum_value;
        // "pipelines R"
        Rpipe <= R;
    end
end

endmodule
