module sr_ff(
    input s,
    input r,
    input clk,
    output reg q,
    output q_bar
    );
    always @(posedge clk) 
    begin 
    case({s,r}) 
    2'b00:q=q;
    2'b01:q=0;
    2'b10:q=1;
    2'b11:q=2'bXX;
    default:q=q;
    endcase
    
    end
    assign q_bar=~q;
endmodule
