module casex_example_18(
  input [3:0] data_in_bus,
  output reg [2:0] data_out_bus
);
  always @* begin
    // The original 'casex (data_in_bus) 4'hX' case item effectively acted as
    // a default case because 'X' in a case item acts as a don't-care for all bits.
    // This caused all subsequent cases (4'h1, 4'h2, default) to be unreachable
    // and led to the 'covered more than once' violations.
    // Therefore, the functional behavior of the original design was to always
    // assign data_out_bus = 3'b000.
    // This change preserves that functional behavior while resolving all violations
    // and avoiding the use of 'casex' as recommended.
    data_out_bus = 3'b000;
  end
endmodule
