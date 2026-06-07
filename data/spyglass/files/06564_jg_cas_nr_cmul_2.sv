module duplicate_case_item_2 (
  input [2:0] data_in,
  output reg  data_out
);

always_comb begin
  case (data_in)
    3'd0: data_out = 1'b0;
    3'd1: data_out = 1'b1;
    3'd2: data_out = 1'b0;
    3'd1: data_out = 1'b1; // Duplicate case item
    3'd3: data_out = 1'b1;
    default: data_out = 1'b0;
  endcase
end

endmodule
