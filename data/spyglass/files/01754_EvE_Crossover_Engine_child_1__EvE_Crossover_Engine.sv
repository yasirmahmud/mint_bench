module EvE_Crossover_Engine(ID, ParentA, ParentB, out, clk,rst, Rand, Config, readA, readB);
input [7:0] ID;
input [63:0] ParentA, ParentB;
input [35:0] Rand;
output reg [63:0] out;
output reg readA, readB;
input [31:0] Config;
input clk, rst;

// Helper module definitions to resolve black-box violations
