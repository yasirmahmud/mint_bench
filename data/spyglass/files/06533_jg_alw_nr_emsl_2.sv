module constant_always_block_2;
  reg [0:0] status_flag;

  always @* begin
    if (1'b1) begin // Condition is a constant
      status_flag = 1'b0;
    end else begin
      status_flag = 1'b1;
    end
  end

endmodule
