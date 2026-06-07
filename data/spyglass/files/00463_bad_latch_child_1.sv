module bad_latch(clk, reset, d, q);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;

  input clk;
  input d;
  output q;
  input reset;

  // Internal register for the latch output to correctly model its behavior
  reg q_internal_reg;

  // Original wire assignments from module inputs
  assign _03_ = reset;
  assign _04_ = d;
  assign _06_ = clk;

  // Replacement for sky130_fd_sc_hd__clkinv_1 (U11: .A(_03_), .Y(_08_))
  assign _08_ = ~_03_;

  // Replacement for sky130_fd_sc_hd__clkinv_1 (U12: .A(_06_), .Y(_09_))
  assign _09_ = ~_06_;

  // Replacement for sky130_fd_sc_hd__nand2_1 (U13: .A(_08_), .B(_09_), .Y(_07_))
  assign _07_ = ~(_08_ & _09_);

  // Replacement for sky130_fd_sc_hd__and2b_2 (U10: .A_N(_03_), .B(_04_), .X(_05_))
  assign _05_ = (~_03_) & _04_;

  // Original assignments connecting intermediate wires to latch inputs
  assign _00_ = _05_; // Latch D input
  assign _02_ = _07_; // Latch E input

  // Replacement for \$_DLATCH_P_ (U14: .D(_00_), .E(_02_), .Q(q))
  // Models a positive level-sensitive latch
  always @(_00_ or _02_) begin
    if (_02_) begin // Latch is transparent when enable (_02_) is high
      q_internal_reg = _00_; // q_internal_reg follows data (_00_)
    end
    // Else, q_internal_reg holds its value (implied by not assigning outside the if)
  end

  // Drive the output 'q' from the internal register
  assign q = q_internal_reg;

endmodule
