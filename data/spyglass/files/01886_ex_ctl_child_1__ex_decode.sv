module ex_decode(
        input [7:0] opcode_1_op_r,
        input [7:0] opcode_2_op_r,
        output [255:0] decodeout_1,
        output [255:0] decodeout_2,
        output invalid_op_r,
        output illegal_op_r
    );
        assign decodeout_1 = 256'b0;
        assign decodeout_2 = 256'b0;
        assign invalid_op_r = 1'b0;
        assign illegal_op_r = 1'b0;
    endmodule
