module PE_11 ( clock , R , S1 , S2 , S1S2mux , newDist , Accumulate , Rpipe ) ;
input  clock ;
input  [7:0] R ;
input  [7:0] S1 ;
input  [7:0] S2 ;
input  S1S2mux ;
input  newDist ;
output reg [7:0] Accumulate ;
output reg [7:0] Rpipe ;

// Internal wires for combinational logic
wire [7:0] AccumulateIn ;
wire [7:0] difference ;
wire [7:0] mux_operand ;
wire Carry ;
wire [7:0] adder_sum_out ;

// D-Flip-flops for Accumulate and Rpipe (replaces DFFX1_LVT instances)
always @(posedge clock) begin
    Accumulate <= AccumulateIn;
    Rpipe <= R;
end

// Mux for S1/S2 (replaces AO22X1_LVT U16-U23 and INVX1_LVT U6)
// Selects between S1 and S2 based on S1S2mux
assign mux_operand = S1S2mux ? S1 : S2;

// Subtractor (replaces PE_11_DW01_sub_1)
// Computes R - mux_operand
assign difference = R - mux_operand;

// Adder (replaces PE_11_DW01_add_0)
// Computes Accumulate + difference with a 9-bit sum (8-bit sum_out + Carry)
// The original blackbox add_56's inputs {1'b0, Accumulate} and {1'b0, difference}
// imply an unsigned 9-bit addition to produce a 9-bit sum {Carry, 8-bit_sum}.
wire [8:0] sum_accum_diff_9bit = {1'b0, Accumulate} + {1'b0, difference};
assign Carry = sum_accum_diff_9bit[8];
assign adder_sum_out = sum_accum_diff_9bit[7:0];

// AccumulateIn logic (replaces INVX1_LVT U5, AND2X1_LVT U7, AO221X1_LVT U8-U15)
// As per the description: "conditionally accumulates this result (difference) into a register when newDist is active"
// When newDist is active, Accumulate stores (Accumulate + difference).
// When newDist is inactive, Accumulate retains its current value.
assign AccumulateIn = newDist ? adder_sum_out : Accumulate;

endmodule
