module sub_module (
  input wire clk,
  input wire rst_n,
  input wire sub_in,
  output reg sub_out
);
  parameter DATA_BITS = 8; // Parameter to be referenced hierarchically

  reg [DATA_BITS-1:0] internal_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_reg <= {DATA_BITS{1'b0}};
    end else begin
      internal_reg <= {internal_reg[DATA_BITS-2:0], sub_in};
    end
  end

  always @(*) begin
    sub_out = internal_reg[DATA_BITS-1]; // Use internal_reg to avoid unused warning
  end

endmodule
