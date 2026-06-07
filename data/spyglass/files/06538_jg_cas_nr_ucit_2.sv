module unequal_case_item_width_2 (
  input [1:0] sel,
  output logic out
);

  always_comb begin
    case (sel)
      4'b0000: out = 1'b0; // Selector (2 bits) vs Case item (4 bits)
      default: out = 1'b1;
    endcase
  end

endmodule
