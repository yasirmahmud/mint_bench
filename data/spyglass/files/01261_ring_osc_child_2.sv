module ring_osc(enable, out);
  output out;
  input enable;

  (* dont_touch = "yes" *) wire w1;
  (* dont_touch = "yes" *) wire w2;
  (* dont_touch = "yes" *) wire w3;
  (* dont_touch = "yes" *) wire w4;
  (* dont_touch = "yes" *) wire w5;
  (* dont_touch = "yes" *) wire w6;
  (* dont_touch = "yes" *) wire w7;
  (* dont_touch = "yes" *) wire w8;
  (* dont_touch = "yes" *) wire w9;
  (* dont_touch = "yes" *) wire w10;
  (* dont_touch = "yes" *) wire w11;
  (* dont_touch = "yes" *) wire w12;
  (* dont_touch = "yes" *) wire w13;
  (* dont_touch = "yes" *) wire w14;
  (* dont_touch = "yes" *) wire w15;

  // Intermediate wire to explicitly break down the gated inverter logic
  // This may help linting tools better understand the intention of the loop closure.
  (* dont_touch = "yes" *) wire w_gated_feedback;

  // The 15th inverter, now with explicit gating logic
  assign w_gated_feedback = enable & w14; // Gating the feedback signal
  (* syn_allow_loop = "true" *) assign w15 = ~w_gated_feedback; // The actual inversion closing the loop

  assign w14 = ~w13;
  assign w13 = ~w12;
  assign w12 = ~w11;
  assign w11 = ~w10;
  assign w10 = ~w9;
  assign w9 = ~w8;
  assign w8 = ~w7;
  assign w7 = ~w6;
  assign w6 = ~w5;
  assign w5 = ~w4;
  assign w4 = ~w3;
  assign w3 = ~w2;
  assign w2 = ~w1;
  assign w1 = ~w15;

  // Changed 'out' assignment to reflect natural language description:
  // "the final inverter’s output is provided as the module’s output."
  // The final inverter in the loop is the one producing w15.
  assign out = w15;

endmodule
