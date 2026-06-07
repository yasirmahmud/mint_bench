// Submodule declaration with an integer parameter
module CONFIG_BLOCK (
  input wire clk,
  output wire busy_out
);
  parameter CONFIG_VALUE = 16; // This integer parameter will be overridden

  reg [4:0] count = 5'd0;
  reg active = 1'b0;

  always @(posedge clk) begin
    if (active) begin
      if (count < CONFIG_VALUE - 1) begin
        count <= count + 1;
      end else begin
        count <= 5'd0;
        active <= 1'b0;
      end
    end else begin
      // Start processing if not active
      active <= 1'b1;
      count <= 5'd0;
    end
  end

  assign busy_out = active;

endmodule
