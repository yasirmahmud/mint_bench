module sr_latch_nand(s,r,q,q_bar);
input s,r;
output q,q_bar; // Outputs are now implicitly wires when driven by gate instantiations

// The SR latch using NAND gates is inherently a latch. The SpyGlass violation
// "InferLatch" indicates that the tool inferred a latch from the behavioral
// description. To resolve this while preserving the latch's functional behavior,
// and explicitly representing it as an SR NAND latch as described, we use
// direct instantiation of NAND primitives.
// This approach avoids the 'inference' of a latch by providing a structural
// description of the cross-coupled NAND gates.

// First NAND gate: Q = ~(S_active_low & Q_bar)
nand gate1 (q, s, q_bar);

// Second NAND gate: Q_bar = ~(R_active_low & Q)
nand gate2 (q_bar, r, q);

endmodule
