module incomplete_case_8;
  reg [3:0] addr;
  reg [7:0] mem_data;
  always @* begin
    case (addr)
      4'h0: mem_data = 8'h00;
      4'h1: mem_data = 8'h01;
      4'h2: mem_data = 8'h02;
      4'h3: mem_data = 8'h03;
      4'h4: mem_data = 8'h04;
      4'h5: mem_data = 8'h05;
      4'h6: mem_data = 8'h06;
      4'h7: mem_data = 8'h07;
    endcase
  end
endmodule
