module CLA(c0, c1, c2, c3, c4, p1, p2, p3, p4, g1, g2, g3, g4);
    input c0;
    input p1, p2, p3, p4;
    input g1, g2, g3, g4;
    output c1, c2, c3, c4;

    assign c1 = g1 | (p1 & c0);
    assign c2 = g2 | (p2 & g1) | (p2 & p1 & c0);
    assign c3 = g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & c0);
    assign c4 = g4 | (p4 & g3) | (p4 & p3 & g2) | (p4 & p3 & p2 & g1) | (p4 & p3 & p2 & p1 & c0);
endmodule
