module counter_add3 (   clk,
                        rstn,                            // It is negative reset
                        out);

  output reg[2:0] out = 3'b000;
  input clk;
  input rstn;

  // This always block will be triggered at the falling edge of clk (0->1)
  // Once inside this block, it checks if the reset is 0, if yes then change out to zero
  // If reset is 1, then design should be allowed to count up, so increment counter
  always @ (negedge clk) begin
    if (! rstn)
      out <= 0;
    else
      out <= out + 1;
  end

  always @(posedge clk) begin

    if(out == 3'b100)
        out <= 3'b000;    // asynchronous sort of reset
  end
endmodule
