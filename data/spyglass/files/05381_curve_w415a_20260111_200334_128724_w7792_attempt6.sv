module curve_w415a_20260111_200334_128724_w7792_attempt6 (
  input wire [3:0] in_data,
  output reg [3:0] out_data
);

  integer i;
  reg [3:0] accumulated_value; // Target signal for W415a violation

  always @(*) begin
    accumulated_value = 4'b0000; // Initialize before loop

    // This loop assigns to 'accumulated_value' multiple times
    // if 'in_data[i]' is high for multiple iterations.
    // SpyGlass will flag this as W415a.
    for (i = 0; i < 4; i = i + 1) begin
      if (in_data[i] == 1'b1) begin
        accumulated_value = accumulated_value | (1'b1 << i); // W415a violation here
      end
    end
    out_data = accumulated_value;
  end

endmodule
