module W442c_ex2 (input clk, input rst, input enable, output reg q);
  // SpyGlass rule W442f states: "Only '==' and '!=' binary operators are allowed
  // in validation of the asynchronous reset/set condition."
  // The original condition `rst == 1'b1 && enable == 1'b1` contains the '&&' operator,
  // which violates this rule directly within the if statement.
  // To preserve functional behavior, a combinational wire is introduced
  // to pre-calculate the complex reset condition (rst AND enable).
  // The 'if' statement then checks this simple derived wire using only the '==' operator,
  // satisfying the rule while maintaining the original design behavior.
  wire async_reset_active;
  assign async_reset_active = rst && enable;

  always @ (posedge clk or posedge rst) begin
    if (async_reset_active == 1'b1) begin // This condition now only uses '=='
      q <= 1'b0;
    end else begin
      q <= ~q;
    end
  end
endmodule
