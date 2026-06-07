module incomplete_case_12;
  reg [3:0] channel_id;
  reg [31:0] channel_data;
  always @* begin
    case (channel_id)
      4'hA: channel_data = 32'hAAAAAAAA;
      4'hB: channel_data = 32'hBBBBBBBB;
      4'hC: channel_data = 32'hCCCCCCCC;
      4'hD: channel_data = 32'hDDDDDDDD;
      4'hE: channel_data = 32'hEEEEEEEE;
    endcase
  end
endmodule
