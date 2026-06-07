module unequal_case_item_width_1 (
  input [3:0] sel,
  output logic out
);

  always_comb begin
    case (sel)
      2'b00: out = 1'b0; // Selector (4 bits) vs Case item (2 bits)
      default: out = 1'b1;
    endcase
  end

endmodule
