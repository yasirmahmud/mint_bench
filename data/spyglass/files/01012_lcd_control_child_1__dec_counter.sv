module dec_counter (
  input clk,
  input rst,
  input load,
  input [23:0] load_value,
  output reg expired,
  output reg [23:0] counter
);

  // Asynchronous active-low reset, consistent with lcd_control module
  always @(posedge clk or negedge rst) begin
    if (~rst) begin
      counter <= '0;
      expired <= 1'b0;
    end else begin
      if (load) begin
        counter <= load_value;
        expired <= 1'b0;
      end else if (counter > 0) begin
        counter <= counter - 1;
        expired <= 1'b0;
      end else begin // counter == 0
        expired <= 1'b1;
        counter <= '0; // Keep at 0
      end
    end
  end

endmodule
