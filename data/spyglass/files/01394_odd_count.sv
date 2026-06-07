module odd_count(
    input clk,
    input reset,
    output reg [7:0]out
    );
        always @(posedge clk) begin
        if(reset)
            out <= 8'b00000001;
        else begin 
          if(out == 8'b11111111)
            out <= 8'b00000001;
          else
            out <= out + 8'b00000010;
        end
    end
endmodule
