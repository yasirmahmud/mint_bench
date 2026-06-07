module sr_latch(S,R,Q,Qbar);
  
input S,R;
output reg Q,Qbar;
  
always @(S or R or Q) begin
  // Implement the SR latch behavior for Q
  if (S && R) begin // Forbidden state: both Q and Qbar become low
    Q = 1'b0;
  end else if (S) begin // Set: S=1, R=0
    Q = 1'b1;
  end else if (R) begin // Reset: S=0, R=1
    Q = 1'b0;
  end
  // else (S=0, R=0): Q holds its value implicitly as it's a 'reg' and not assigned here.
end
  
always @(S or R or Qbar) begin
  // Implement the SR latch behavior for Qbar
  if (S && R) begin // Forbidden state: both Q and Qbar become low
    Qbar = 1'b0;
  end else if (S) begin // Set: S=1, R=0
    Qbar = 1'b0;
  end else if (R) begin // Reset: S=0, R=1
    Qbar = 1'b1;
  end
  // else (S=0, R=0): Qbar holds its value implicitly as it's a 'reg' and not assigned here.
end
  
endmodule
