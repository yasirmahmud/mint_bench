module counter22 (  clk,
                    rstn,
                    out);

  output reg[3:0] out = 4'b0000;
  input clk;
  input rstn;

  always @ (negedge clk) begin
    if(rstn)
      out <= out + 1;
    else
        out = 4'h0;
  end

  always @(*)
  begin
    if(! rstn)
        out =4'b0000;
  end

endmodule
