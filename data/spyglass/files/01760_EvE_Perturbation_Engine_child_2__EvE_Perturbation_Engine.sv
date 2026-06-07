module EvE_Perturbation_Engine(Crossover, ChildGene, Rand, Config);
input [63:0] Crossover;
output [63:0] ChildGene;
input [35:0] Rand;
input [31:0] Config;

wire[3:0] Select;
wire[31:0] Mutated;
wire[31:0] Perturbation;

// Original Perturbation assignments had a multiple driver issue on Perturbation[11].
// The corrected assignment uses concatenation to ensure each bit is driven exactly once,
// preserving the intended bit mapping and the effective value of '0' for Perturbation[11]
// that resulted from the original conflicting assignments.
assign Perturbation[31:0] = {
    5'b0,             // Perturbation[31:27]
    Rand[2:0],        // Perturbation[26:24]
    5'b0,             // Perturbation[23:19]
    Rand[5:3],        // Perturbation[18:16]
    4'b0,             // Perturbation[15:12]
    1'b0,             // Perturbation[11] (explicitly 0)
    Rand[8:6],        // Perturbation[10:8]
    5'b0,             // Perturbation[7:3]
    Rand[11:9]        // Perturbation[2:0]
};

assign Mutated[31:24] = Crossover[31:24] + Perturbation[31:24];
assign Mutated[23:16] = Crossover[23:16] + Perturbation[23:16];
assign Mutated[15:8] = Crossover[15:8] + Perturbation[15:8];
assign Mutated[7:0] = Crossover[7:0] + Perturbation[7:0];

assign ChildGene[63:32] = Crossover[63:32];

// Fixed multiple driver issue on 'lw' by disconnecting unused 'lower' outputs.
// Also resolved unused 'equal' output warnings by explicitly leaving them unconnected.
comparator #(32) compID1(.a(Rand[35:4]),.b(Config[31:0]),.equal(),.lower(),.greater(Select[3]));
comparator #(32) compID2(.a(Rand[34:3]),.b(Config[31:0]),.equal(),.lower(),.greater(Select[2]));
comparator #(32) compID3(.a(Rand[33:2]),.b(Config[31:0]),.equal(),.lower(),.greater(Select[1]));
comparator #(32) compID4(.a(Rand[32:1]),.b(Config[31:0]),.equal(),.lower(),.greater(Select[0]));

mux_2to1_8bit bits31to24(.a(Mutated[31:24]), .b(Crossover[31:24]), .select(Select[3]), .out(ChildGene[31:24]));
mux_2to1_8bit bits23to16(.a(Mutated[23:16]), .b(Crossover[23:16]), .select(Select[2]), .out(ChildGene[23:16]));
mux_2to1_8bit bits15to8(.a(Mutated[15:8]), .b(Crossover[15:8]), .select(Select[1]), .out(ChildGene[15:8]));
mux_2to1_8bit bits7to0(.a(Mutated[7:0]), .b(Crossover[7:0]), .select(Select[0]), .out(ChildGene[7:0]));

endmodule
