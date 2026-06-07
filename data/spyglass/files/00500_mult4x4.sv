module mult4x4  (
    input wire Clk,
    input wire St,
    input wire [3:0] Mplier,
    input wire [3:0] Mcand,
    output wire Done,
    output wire [7:0] Result
    );

    
   
    reg[3:0] State;
    reg[8:0] ACC;
    initial
    begin
        State = 0;
        ACC = 0;
    end
    always @(posedge Clk)
    begin
        case (State)
            0 :
                begin
                if (St ==1'b1)
                begin
                    ACC[8:4] <= 5'b00000 ;
                    ACC[3:0] <= Mplier ;
                    State <= 1 ;
                end
                end
            1, 3, 5, 7 :
                begin
                if (`M == 1'b1)
                begin
                    ACC[8:4] <= {1'b0, ACC[7:4]} + Mcand ;
                    State <= State + 1 ;
                end
                else
                begin
                    ACC <= {1'b0, ACC[8:1]} ;
                    State <= State + 2 ;
                end
                end
             2, 4, 6, 8 :
                begin
                    ACC <= {1'b0, ACC[8:1]} ;
                    State <= State + 1 ;
                end
            9 :
                begin
                    State <= 0 ;
                end
            endcase
        end
        assign Done = (State == 9) ? 1'b1 : 1'b0 ;
        assign Result = (State == 9) ? ACC[7:0] : 8'b01010101 ;
endmodule
