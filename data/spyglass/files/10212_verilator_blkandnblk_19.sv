module ex19;
  reg s;
  always @* begin
    s = 1'b1;
    s <= 1'b0;
    #1; // Delay within the block doesn't prevent warning
  end
endmodule
