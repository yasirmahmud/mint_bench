`define GLOBAL_SETTING 5

module wrn_26_example_v8 (
  input wire clk,
  input wire rst_n,
  input wire [3:0] data_in,
  output reg [3:0] data_out
);

  // WRN_26: Redefinition of macro GLOBAL_SETTING
  `define GLOBAL_SETTING 10

  // Dummy logic to ensure ports are used and macro is referenced,
  // avoiding other warnings like unused signals or latches.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 4'h0;
    end else begin
      // This branch will be taken as GLOBAL_SETTING is redefined to 10
      if (`GLOBAL_SETTING == 10) begin
        data_out <= data_in + 4'd1;
      end else begin
        data_out <= data_in;
      end
    end
  end

endmodule
