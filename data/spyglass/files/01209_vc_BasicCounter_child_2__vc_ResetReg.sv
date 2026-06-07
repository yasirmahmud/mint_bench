module vc_ResetReg
#(
  parameter WIDTH       = 1,
  parameter RESET_VALUE = 0
)(
  input  wire          clk,
  input  wire          reset,
  input  wire [WIDTH-1:0] d,
  output reg  [WIDTH-1:0] q
);

  always_ff @( posedge clk ) begin
    if ( reset ) begin
      q <= RESET_VALUE;
    end else begin
      q <= d;
    end
  end

endmodule
