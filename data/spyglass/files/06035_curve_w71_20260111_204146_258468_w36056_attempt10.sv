module curve_w71_20260111_204146_258468_w36056_attempt10 (
  input wire [1:0] sel,
  input wire [7:0] a,
  input wire [7:0] b,
  input wire [7:0] c,
  output reg [7:0] y
);

  always @(*) begin
    // W71: Case statement does not have a default clause and is not preceded by assignment of target signal.
    // 'y' is not assigned before the case statement, and 'sel' (2 bits) does not cover all 4 possible values.
    case (sel)
      2'b00: y = a;
      2'b01: y = b;
      2'b10: y = c;
      // 2'b11 is not covered, and there is no default clause.
      // This creates an incomplete case, triggering W71.
    endcase
  end

endmodule
