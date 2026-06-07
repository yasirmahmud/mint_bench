module PE_9 ( clock , R , S1 , S2 , S1S2mux , newDist , Accumulate , Rpipe ) ;
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
wire [7:0] selected_S; // Output of S1/S2 multiplexer
wire Carry_out_adder;  // Carry output from the 8-bit adder
wire [7:0] sum_result_8bit; // The 8-bit sum of Accumulate and difference

// Mux for S1/S2 selection, replaces AO22X1_LVT instances (U16-U23)
// Y = (S1 & S1S2mux) | (S2 & ~S1S2mux)
assign selected_S = S1S2mux ? S1 : S2;

// Subtraction to compute difference, replaces PE_9_DW01_sub_1 instance sub_50
assign difference = R - selected_S;

// Addition to compute Accumulate + difference, replaces PE_9_DW01_add_0 instance add_56
// The inputs to the adder are effectively zero-extended 8-bit values.
// {Carry_out_adder, sum_result_8bit} represents the 9-bit result of the 8-bit unsigned addition.
assign {Carry_out_adder, sum_result_8bit} = {1'b0, Accumulate} + {1'b0, difference};

// Logic for AccumulateIn, replaces INVX1_LVT (U5, U6), AND2X1_LVT (U7), and AO221X1_LVT (U8-U15) instances.
// The natural language description specifies "adds that difference to an accumulated value".
// The gate-level implementation also shows control via 'newDist'.
// If newDist is high, Accumulate is loaded with the new difference (resetting the accumulation).
// If newDist is low, Accumulate adds the difference to its current value (carry_out_adder is ignored for the 8-bit Accumulate output).
assign AccumulateIn = newDist ? difference : sum_result_8bit;

// D-Flip-flops for Rpipe, replaces DFFX1_LVT instances (\Rpipe_reg[0-7])
always @(posedge clock) begin
    Rpipe <= R;
end

// D-Flip-flops for Accumulate, replaces DFFX1_LVT instances (\Accumulate_reg[0-7])
always @(posedge clock) begin
    Accumulate <= AccumulateIn;
end

endmodule
