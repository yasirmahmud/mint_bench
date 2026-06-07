module const_write_19;
  logic [7:0] byte_data = 8'h12;
  initial begin
    if (1) begin
      byte_data = 8'h34;
    end
  end
endmodule
