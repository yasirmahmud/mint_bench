module curve_w215_20260111_002217_attempt3 (
    input clk,
    input rst,
    output reg [3:0] data_out
);

  integer my_int;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      data_out <= 4'b0;
      my_int <= 0; // Initialize integer
    end else begin
      my_int <= my_int + 1; // Change the integer value
      // Perform bit selections on the integer variable 'my_int'.
      // Each instance of "my_int[bit_index]" triggers a W215 violation.
      data_out[0] <= my_int[0]; // Triggers W215
      data_out[1] <= my_int[1]; // Triggers W215
      data_out[2] <= my_int[2]; // Triggers W215
      data_out[3] <= my_int[3]; // Triggers W215
    end
  end

endmodule
