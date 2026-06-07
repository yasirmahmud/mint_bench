module expand_key_128 (clk, in, out_1, out_2, rcon);

    input              clk;
    input      [127:0] in;
    input      [7:0]   rcon;
    output reg [127:0] out_1;
    output     [127:0] out_2;
    wire       [31:0]  k0, k1, k2, k3,
                       v0, v1, v2, v3;
    reg        [31:0]  k0a, k1a, k2a, k3a;
    wire       [31:0]  k0b, k1b, k2b, k3b, k4a;

    assign {k0, k1, k2, k3} = in;
    
    // The description mentions rotation and substitution. The input to S4 is rotated k3.
    // AES key expansion typically uses Rcon XORed with the first byte after SubWord/RotWord,
    // but here v0 calculation seems different. It applies Rcon only to the MSB of k0.
    assign v0 = {k0[31:24] ^ rcon, k0[23:0]}; // This is peculiar, but matches the given RTL.
    assign v1 = v0 ^ k1;
    assign v2 = v1 ^ k2;
    assign v3 = v2 ^ k3;

    always @ (posedge clk)
        {k0a, k1a, k2a, k3a} <= {v0, v1, v2, v3};

    // S4 performs substitution, and its input {k3[23:0], k3[31:24]} is a left rotation of k3.
    // This matches the RotWord and SubWord steps in AES key expansion.
    S4
        S4_0 (. 
        clk(clk),
        .in_word({k3[23:0], k3[31:24]}), // RotWord(k3)
        .out_word(k4a)                    // SubWord(RotWord(k3))
        );

    assign k0b = k0a ^ k4a;
    assign k1b = k1a ^ k4a;
    assign k2b = k2a ^ k4a;
    assign k3b = k3a ^ k4a;

    always @ (posedge clk)
        out_1 <= {k0b, k1b, k2b, k3b};

    assign out_2 = {k0b, k1b, k2b, k3b};
endmodule
