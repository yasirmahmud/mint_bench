module sr_ff(clk, S, R, Q, Q_bar);
  input clk;
  input S;
  input R;
  output reg Q;
  output reg Q_bar;

  always @(posedge clk) begin
    if (S == 1'b1 && R == 1'b0) begin // Set
      Q <= 1'b1;
      Q_bar <= 1'b0;
    end else if (S == 1'b0 && R == 1'b1) begin // Reset
      Q <= 1'b0;
      Q_bar <= 1'b1;
    end
    // If S==0 and R==0, Q and Q_bar hold their previous values.
    // The (S==1 && R==1) state is forbidden and not reachable when used as a DFF.
  end

  // Add an initial block to prevent X propagation at time 0 in simulation
  // without affecting synchronous behavior.
  initial begin
    Q = 1'b0;
    Q_bar = 1'b1;
  end

endmodule
