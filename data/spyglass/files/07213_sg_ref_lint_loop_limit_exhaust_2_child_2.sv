module infinite_loop_ex2;
  initial begin
    while (1) begin
      #1;
    end
  end
endmodule
