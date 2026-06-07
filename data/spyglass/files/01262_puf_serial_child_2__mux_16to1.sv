module mux_16to1(
    input in0,
    input in1,
    input in2,
    input in3,
    input in4,
    input in5,
    input in6,
    input in7,
    input in8,
    input in9,
    input in10,
    input in11,
    input in12,
    input in13,
    input in14,
    input in15,
    input [3:0] select,
    output out
    );
    // Implemented basic 16-to-1 multiplexer logic to consume all inputs
    assign out = (select == 4'd0) ? in0 :
                 (select == 4'd1) ? in1 :
                 (select == 4'd2) ? in2 :
                 (select == 4'd3) ? in3 :
                 (select == 4'd4) ? in4 :
                 (select == 4'd5) ? in5 :
                 (select == 4'd6) ? in6 :
                 (select == 4'd7) ? in7 :
                 (select == 4'd8) ? in8 :
                 (select == 4'd9) ? in9 :
                 (select == 4'd10) ? in10 :
                 (select == 4'd11) ? in11 :
                 (select == 4'd12) ? in12 :
                 (select == 4'd13) ? in13 :
                 (select == 4'd14) ? in14 :
                 in15; // default to in15 if select is 4'd15
endmodule
