module casex_example_16(
  input [2:0] control_bits,
  output reg [1:0] output_state
);
  always @* begin
    // Verilator warning CASEX resolved by converting to 'casez'
    // and explicitly marking don't-care bits with '?'
    // This also resolves the SpyGlass W398 violation regarding overlapping cases.
    // In 'casez', '?' in the case item acts as a don't-care.
    // The cases are evaluated in order, so 3'b??? acts as a default.
    casez (control_bits)
      3'b0?1: output_state = 2'b00;
      3'b1?0: output_state = 2'b01;
      3'b???: output_state = 2'b10;
    endcase
  end
endmodule
