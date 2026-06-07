module duplicate_case_item_1 (
  input [1:0] sel,
  output reg  out
);

always_comb begin
  case (sel)
    2'b00: out = 1'b0;
    2'b01: out = 1'b1;
    2'b00: out = 1'b0; // Duplicate case item
    default: out = 1'b0;
  endcase
end

endmodule
