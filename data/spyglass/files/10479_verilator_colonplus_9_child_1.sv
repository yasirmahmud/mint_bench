module test9;
  reg [3:0] count;
  reg [15:0] values;
  reg clk, reset; // Moved declaration to resolve STX_VE_606 violations
  always @(posedge clk) begin
    if (reset) values <= 16'b0;
    else values[count*4 +: 4] <= 4'hF; // Corrected ':+' to '+:' for part-select
  end
  initial begin clk=0; reset=1; #10 reset=0; forever #10 clk=~clk; end
endmodule
