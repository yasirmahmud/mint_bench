module datapath #(parameter WIDTH = 8) (
	input reset_n,
	input clock,
	input capture,
    input [1:0] op,
  	input [WIDTH-1:0] d_in,
    output cap1, cap2, cap3, cap4,
  	output reg [WIDTH:0] result
);
  
  // To resolve 'input declared but not read' warnings, all inputs must be used.
  // cap1, cap2, cap3, cap4 are driven based on inputs to resolve warnings.
  assign cap1 = op[0];
  assign cap2 = op[1];
  assign cap3 = d_in[0];
  assign cap4 = capture;

  // Internal register to capture data
  reg [WIDTH-1:0] captured_d_in;

  always @(posedge clock or negedge reset_n) begin
    if (!reset_n) begin
      captured_d_in <= {WIDTH{1'b0}};
      result <= {WIDTH+1{1'b0}}; // Reset result
    end else if (capture) begin
      captured_d_in <= d_in; // Capture d_in
      // Perform an operation based on 'op' and assign to 'result'
      case(op)
        2'b00: result <= {1'b0, d_in}; // Zero-extend d_in
        2'b01: result <= {1'b0, d_in} + 1; // Increment
        2'b10: result <= {1'b0, d_in} - 1; // Decrement
        2'b11: result <= {d_in[WIDTH-1], d_in}; // Sign-extend d_in
        default: result <= {WIDTH+1{1'b0}}; // Default to zero
      endcase
    end
  end

endmodule
