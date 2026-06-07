module curve_stx_ve_775_20260110_200225_attempt6 (
  input wire dummy_in,
  output reg [7:0] dummy_out
);

  // STX_VE_775: Initial statement not allowed in this scope
  // An 'initial' block is not permitted inside a Verilog-2001 function.
  function automatic [7:0] my_func (input [7:0] in_val);
    initial begin // This line is expected to trigger STX_VE_775
      // This 'initial' block is in an illegal scope (inside a function).
    end
    my_func = in_val + 1;
  endfunction

  always @(dummy_in) begin
    dummy_out = my_func(8'd0);
  end

endmodule
