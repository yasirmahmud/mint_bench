module even_odd_parity  (x, clk, z);

    input x, clk;
    output reg z;
    reg even_odd; //the FSM state
    parameter EVEN = 0, ODD = 1;

    always@(posedge clk) begin
        case(even_odd)
            EVEN:
            begin
                z <= x?1:0;
                even_odd <= x?ODD:EVEN;
            end
            ODD:
            begin
                z <= x?0:1;
                even_odd <= x?EVEN:ODD;
            end
            default: even_odd <= EVEN; //assume for reset it is EVEN state
        endcase
    end
endmodule
