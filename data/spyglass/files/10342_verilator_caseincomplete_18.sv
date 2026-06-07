module incomplete_case_18;
  reg [2:0] bus_arbiter_req;
  reg bus_grant;
  always @* begin
    case (bus_arbiter_req)
      3'b001: bus_grant = 1'b1;
      3'b010: bus_grant = 1'b0;
      3'b100: bus_grant = 1'b1;
      3'b110: bus_grant = 1'b0;
    endcase
  end
endmodule
