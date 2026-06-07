`define MY_CONFIG_VALUE 100

module wrn_26_test_v7 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] in_data,
  output reg [7:0] out_data
);

  // WRN_26: Redefinition of macro MY_CONFIG_VALUE
  `define MY_CONFIG_VALUE 200

  // Dummy logic to use ports and the macro, avoiding other warnings
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data <= 8'h00;
    end else begin
      // This branch will be taken as MY_CONFIG_VALUE is redefined to 200
      if (`MY_CONFIG_VALUE == 200) begin
        out_data <= in_data + 8'd1;
      end else begin
        out_data <= in_data;
      end
    end
  end

endmodule
