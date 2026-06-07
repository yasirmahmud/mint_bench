module curve_w415a_20260111_160035_923474_w21676_attempt1 (
  input wire clk,
  input wire rst,
  input wire [7:0] data_in,
  output reg [7:0] result
);

  reg [7:0] temp_val; // Signal targeted for W415a violation
  integer i;          // Loop variable

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      result <= 8'd0;
      temp_val <= 8'd0;
    end else begin
      temp_val = 8'd0; // First assignment to temp_val within the cycle

      // The 'for' loop assigns to 'temp_val' multiple times in the same cycle
      // This triggers W415a for 'temp_val'
      for (i = 0; i < 8; i = i + 1) begin
        if (data_in[i]) begin
          temp_val = temp_val + 1; // Multiple assignments to temp_val within loop
        end
      end
      result <= temp_val; // Capture final calculated value
    end
  end

endmodule
