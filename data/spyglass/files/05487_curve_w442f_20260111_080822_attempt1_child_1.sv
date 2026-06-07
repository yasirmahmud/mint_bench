module curve_w442f_20260111_080822_attempt1 (
  input wire clk,
  input wire reset_a,
  input wire reset_b,
  input wire data_in,
  output reg data_out
);

  always_ff @(posedge clk or negedge (reset_a && reset_b)) begin
    // W442f violation: The asynchronous reset condition uses logical operators '!' and '&&'
    // in its validation, instead of only '==' or '!='.
    if ((reset_a && reset_b) == 1'b0) begin // Fixed: Changed !(reset_a && reset_b) to (reset_a && reset_b) == 1'b0
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    }
  end

endmodule
