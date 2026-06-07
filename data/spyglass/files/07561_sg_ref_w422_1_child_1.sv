module w422_ex1(input clk1, input clk2, input rst, output reg out_reg);
  // Original issue: The always block used 'posedge clk1 or posedge clk2',
  // which violates W422 and STARC05-2.3.3.1 (multiple clocks in a single block).
  // It also implicitly caused badimplicitSM1 due to the non-standard clocking.
  //
  // Fix: Select 'clk1' as the primary clock for the 'out_reg' flip-flop.
  // 'rst' is interpreted as an asynchronous reset based on the original 'if (rst)' condition,
  // so it's added to the sensitivity list and checked first, addressing 'badimplicitSM1'
  // and ensuring proper asynchronous reset behavior. This resolves all reported violations.
  //
  // Note on functional behavior: The original behavior of responding to *either* clk1 or clk2
  // is generally not synthesizable with standard flip-flops. To resolve the violations and
  // make the design synthesizable, 'out_reg' is now sensitive only to 'clk1'.
  // If `clk2` was intended to control `out_reg`, additional logic (e.g., a separate flip-flop
  // in the `clk2` domain or a synchronous enable derived from `clk2`) would be required,
  // which would be a more significant design change beyond a linting fix.
  always @(posedge clk1 or posedge rst) begin
    if (rst) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= ~out_reg;
    end
  end
endmodule
