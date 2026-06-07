module curve_synth_12605_20260111_013718_attempt4 (
  input [1:0] sel_in,
  output reg out_0,
  output reg out_1,
  output reg out_2,
  output reg out_3,
  output reg out_4
);

  // Instance 1: Incomplete priority type case (if-else if) for out_0
  // Missing conditions for sel_in == 2'b10 and 2'b11
  always @* begin
    if (sel_in == 2'b00) begin
      out_0 = 1'b0;
    end else if (sel_in == 2'b01) begin
      out_0 = 1'b1;
    end
  end

  // Instance 2: Incomplete priority type case (if-else if) for out_1
  // Missing conditions for sel_in == 2'b10 and 2'b11
  always @* begin
    if (sel_in == 2'b00) begin
      out_1 = 1'b1;
    end else if (sel_in == 2'b01) begin
      out_1 = 1'b0;
    end
  end

  // Instance 3: Incomplete priority type case (if-else if) for out_2
  // Missing conditions for sel_in == 2'b01 and 2'b11
  always @* begin
    if (sel_in == 2'b00) begin
      out_2 = 1'b0;
    end else if (sel_in == 2'b10) begin
      out_2 = 1'b1;
    end
  end

  // Instance 4: Incomplete priority type case (if-else if) for out_3
  // Missing conditions for sel_in == 2'b00 and 2'b10
  always @* begin
    if (sel_in == 2'b01) begin
      out_3 = 1'b0;
    end else if (sel_in == 2'b11) begin
      out_3 = 1'b1;
    end
  end

  // Instance 5: Incomplete priority type case (if-else if) for out_4
  // Missing conditions for sel_in == 2'b00 and 2'b01
  always @* begin
    if (sel_in == 2'b10) begin
      out_4 = 1'b0;
    end else if (sel_in == 2'b11) begin
      out_4 = 1'b1;
    end
  end

endmodule
