module ex13;
  reg m;
  always @* begin
    m = 1'b1;
    fork
      m <= 1'b0;
    join
  end
endmodule
