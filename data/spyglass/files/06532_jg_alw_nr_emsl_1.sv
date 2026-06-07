module constant_always_block_1;
  reg [3:0] out_val;

  always @* begin
    out_val = 4'd10; // Only a constant is used
  end

endmodule
