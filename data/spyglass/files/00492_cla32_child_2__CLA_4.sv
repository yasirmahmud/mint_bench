module CLA_4 (
    input wire [3:0] A,
    input wire [3:0] B,
    input wire Cin,
    output wire [3:0] S,
    output wire Cout,
    output wire P, // Group propagate
    output wire G  // Group generate
);

    // Intermediate propagate and generate for each bit
    wire [3:0] P_local;
    wire [3:0] G_local;

    // Internal carries
    wire [4:0] C; // C[0] is Cin, C[4] is Cout

    // Calculate P_local and G_local for each bit
    assign P_local = A ^ B;
    assign G_local = A & B;

    // Assign Cin to C[0]
    assign C[0] = Cin;

    // Calculate internal carries using lookahead logic
    assign C[1] = G_local[0] | (P_local[0] & C[0]);
    assign C[2] = G_local[1] | (P_local[1] & C[1]);
    assign C[3] = G_local[2] | (P_local[2] & C[2]);
    assign C[4] = G_local[3] | (P_local[3] & C[3]);

    // Calculate sum bits
    assign S[0] = P_local[0] ^ C[0];
    assign S[1] = P_local[1] ^ C[1];
    assign S[2] = P_local[2] ^ C[2];
    assign S[3] = P_local[3] ^ C[3];

    // Assign Cout for the block
    assign Cout = C[4];

    // Calculate group propagate (P)
    assign P = P_local[0] & P_local[1] & P_local[2] & P_local[3];

    // Calculate group generate (G)
    // G = G3 | (P3 & G2) | (P3 & P2 & G1) | (P3 & P2 & P1 & G0)
    assign G = G_local[3] |
               (P_local[3] & G_local[2]) |
               (P_local[3] & P_local[2] & G_local[1]) |
               (P_local[3] & P_local[2] & P_local[1] & G_local[0]);

endmodule
