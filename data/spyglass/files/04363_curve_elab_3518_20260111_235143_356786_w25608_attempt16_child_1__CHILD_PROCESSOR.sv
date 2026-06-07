module CHILD_PROCESSOR (
  parameter integer CLOCK_DIVISOR = 10,
  input wire clk_in,
  output wire proc_out
);
  // A simple counter that uses the CLOCK_DIVISOR parameter.
  // This ensures the parameter is functionally relevant within the module.
  reg [3:0] counter;

  always @(posedge clk_in) begin
    if (counter == CLOCK_DIVISOR - 1) begin
      counter <= 0;
    end else begin
      counter <= counter + 1;
    }
  end

  // Drive the output based on the counter state to ensure 'proc_out' is used.
  assign proc_out = (counter == 0);
endmodule
