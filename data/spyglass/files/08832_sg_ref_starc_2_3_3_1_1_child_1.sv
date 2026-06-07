module STARC_2_3_3_1_ex1(input clk1, input clk2, input d1, output reg q1);
    always @(posedge clk1) begin 
        q1 <= d1;
    end
endmodule
