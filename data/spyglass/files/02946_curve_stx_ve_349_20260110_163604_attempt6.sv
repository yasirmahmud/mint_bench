module curve_stx_ve_349_20260110_163604_attempt6 (
  input wire clk,
  input wire rst,
  output reg [3:0] counter_out
);

  integer i;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      counter_out <= 4'h0;
    end else begin
      // A 'for' loop is used to provide context similar to provided examples,
      // but the violation is triggered by calling an undefined task 'exit'.
      for (i = 0; i < 10; i = i + 1) begin
        if (i == 5) begin
          exit; // STX_VE_349: Task or function name ( exit ) not defined
        end
      end
      counter_out <= counter_out + 1;
    end
  end

endmodule
