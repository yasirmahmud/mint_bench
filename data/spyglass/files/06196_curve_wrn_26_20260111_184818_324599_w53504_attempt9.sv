`define MY_CONFIG_VALUE 10

module wrn_26_example_v9 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // WRN_26: Redefinition of macro 'MY_CONFIG_VALUE'
  `define MY_CONFIG_VALUE 20

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      // Simple logic to use all ports and the macro,
      // avoiding unused signal warnings.
      if (`MY_CONFIG_VALUE > data_in) begin
        data_out <= data_in + 8'd1;
      end else begin
        data_out <= data_in - 8'd1;
      end
    end
  end

endmodule
