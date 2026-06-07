module curve_w352_20260111_031016_attempt1;
  integer i;

  initial begin
    // W352: The 'for' condition is constant - the loop will either never execute or never terminate
    for (i = 0; 1'b1; i = i + 1) begin
      // This loop will never terminate
    end
  end
endmodule
