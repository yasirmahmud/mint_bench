module NonConstantDelay2 (
  input [7:0] in_data,
  output reg [7:0] out_data,
  input [3:0] dynamic_delay_val // Input port used as delay
);

  always @(in_data or dynamic_delay_val) begin
    #(dynamic_delay_val) out_data = in_data; // Violation: dynamic_delay_val is not a constant expression
  end

endmodule
