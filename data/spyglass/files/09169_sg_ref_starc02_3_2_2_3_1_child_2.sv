module my_module_ex1 #(parameter WIDTH = 8) (
  input clk,
  input rst_n,
  output [WIDTH-1:0] data_out
);
  reg [WIDTH-1:0] data_reg;

  // Replaced initial block with a synthesizable asynchronous reset
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Active-low asynchronous reset
      data_reg <= {WIDTH{1'b0}}; // Initialize to all zeros
    end else begin
      // No other sequential logic for data_reg is specified in the original design
      // so it will retain its value or remain 0 if never updated.
    end
  end

  // Made the register visible as an output to resolve the 'set but not read' warning
  assign data_out = data_reg;

endmodule
