module curve_w66_20260111_004713_attempt1 ();

  reg [3:0] count1;
  reg [3:0] count2;
  reg [3:0] count3;
  reg [3:0] count4;
  reg       out_signal;

  initial begin
    count1 = 4'd1;
    count2 = 4'd2;
    count3 = 4'd3;
    count4 = 4'd4;
    out_signal = 1'b0;

    // W66 Violation 1: Repeat expression is not constant (Fixed by unrolling)
    out_signal = ~out_signal;

    // W66 Violation 2: Repeat expression is not constant (Fixed by unrolling)
    out_signal = ~out_signal;
    out_signal = ~out_signal;

    // W66 Violation 3: Repeat expression is not constant (Fixed by unrolling)
    out_signal = ~out_signal;
    out_signal = ~out_signal;
    out_signal = ~out_signal;

    // W66 Violation 4: Repeat expression is not constant (Fixed by unrolling)
    out_signal = ~out_signal;
    out_signal = ~out_signal;
    out_signal = ~out_signal;
    out_signal = ~out_signal;
  end

endmodule
