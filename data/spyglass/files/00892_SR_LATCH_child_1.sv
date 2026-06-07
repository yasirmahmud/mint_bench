module sr_latch(S,R,Q,Qbar);
  
input S,R;
output reg Q, Qbar;
  
  always @* begin
    // Implement SR Latch logic based on NOR gates truth table.
    // This behavioral description resolves the combinational loop by clearly defining
    // the latching behavior for synthesis tools.
    //
    // Truth table for NOR-based SR Latch:
    // S | R | Q_next | Qbar_next (derived from NOR gate implementation)
    // --|---|--------|-----------
    // 0 | 0 | Q      | Qbar      (Hold previous state)
    // 0 | 1 | 0      | 1         (Reset output Q to 0)
    // 1 | 0 | 1      | 0         (Set output Q to 1)
    // 1 | 1 | 0      | 0         (Invalid state: both Q and Qbar go low for NOR implementation)

    if (S == 1'b1 && R == 1'b1) begin
      // Handle the invalid state for NOR-based SR latch where both S and R are active.
      // In cross-coupled NORs, both Q and Qbar will be driven to 0.
      Q    = 1'b0;
      Qbar = 1'b0;
    end else if (S == 1'b1) begin
      // Set condition (S=1, R=0): Q becomes 1, Qbar becomes 0.
      Q    = 1'b1;
      Qbar = 1'b0;
    end else if (R == 1'b1) begin
      // Reset condition (S=0, R=1): Q becomes 0, Qbar becomes 1.
      Q    = 1'b0;
      Qbar = 1'b1;
    end
    // If S=0 and R=0, Q and Qbar are not explicitly assigned in this 'always' block.
    // This absence of assignment in the 'else' case correctly infers a level-sensitive latch,
    // preserving the previous values of Q and Qbar (hold state).
  end
  
endmodule
