module wrn_26_example_v10 (
  input wire clk,
  input wire rst,
  input wire [3:0] enable,
  output reg [3:0] count_out
);

  // Initial definition of the macro
  `define MAX_COUNT 5

  // WRN_26: This redefinition triggers the violation.
  `define MAX_COUNT 15

  // Use the macro to avoid unused warnings. It will take the last defined value.
  parameter initial_limit = `MAX_COUNT;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      count_out <= 4'h0;
    end else begin
      if (enable != 4'b0) begin // Check if 'enable' is active
        if (count_out < initial_limit) begin
          count_out <= count_out + 4'd1;
        end else begin
          count_out <= 4'h0;
        end
      end
    end
  end

endmodule
