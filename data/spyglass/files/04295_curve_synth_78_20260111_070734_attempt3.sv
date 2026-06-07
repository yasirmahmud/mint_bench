module curve_synth_78_20260111_070734_attempt3 (
  input wire clk,
  input wire rst_n,
  input wire enable_i,
  output reg busy_o
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      busy_o <= 1'b0;
    end else begin
      // This 'wait' statement is a simulation construct and not synthesizable.
      // It will trigger the SYNTH_78 rule.
      if (enable_i) begin
        wait (enable_i == 1'b0); // SYNTH_78: 'wait' construct is not synthesizable
        busy_o <= 1'b1;
      end else begin
        busy_o <= 1'b0;
      end
    end
  end

endmodule
