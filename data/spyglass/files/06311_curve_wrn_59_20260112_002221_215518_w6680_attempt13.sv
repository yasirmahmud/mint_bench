module curve_wrn_59_20260112_002221_215518_w6680_attempt13 (
    input wire clk,
    input wire rst,
    input wire data_in,
    output reg out_reg
);

  // Declare an internal net to be monitored by $countdrivers.
  // This also ensures data_in is used if not directly assigned to out_reg without rst.
  wire internal_net = data_in;

  // Synchronous logic to demonstrate usage of all input ports and avoid unused signal warnings.
  always @(posedge clk) begin
    if (rst) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= data_in;
    end
  end

  // WRN_59: System function ($countdrivers) specified when a system task was expected in this context
  // The $countdrivers system function returns a value, but here it is used as a standalone statement.
  // Its return value is not assigned to any variable or used in an expression, 
  // thus it acts as if a system task were expected in this context.
  always @(posedge clk) begin
    $countdrivers(internal_net);
  end

endmodule
