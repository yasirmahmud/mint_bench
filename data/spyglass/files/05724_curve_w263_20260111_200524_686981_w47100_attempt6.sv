module curve_w263_20260111_200524_686981_w47100_attempt6 (
  input wire [2:0] selector_in,
  output reg out_val
);

  // Selector for the case statement, 3 bits wide.
  reg [2:0] current_selector;

  // This localparam will have a width of 1 bit.
  localparam S_MISMATCH = 1'b1; // Width = 1

  // These localparams will have a width of 3 bits, matching the selector.
  localparam [2:0] S_MATCH_0 = 3'd0; // Width = 3
  localparam [2:0] S_MATCH_2 = 3'd2; // Width = 3

  always @(*) begin
    current_selector = selector_in;

    case (current_selector) // Selector width is 3 bits
      S_MISMATCH: begin // This label (1 bit) mismatches selector (3 bits) - W263 violation
        out_val = 1'b0;
      end
      S_MATCH_0: begin
        out_val = 1'b1;
      end
      S_MATCH_2: begin
        out_val = 1'b0;
      end
      default: begin
        out_val = 1'b1;
      end
    endcase
  end

endmodule
