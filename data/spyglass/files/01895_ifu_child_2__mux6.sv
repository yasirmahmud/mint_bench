module mux6 (
    output out,
    input in0, input in1, input in2, input in3, input in4, input in5,
    input [2:0] sel
);
    reg r_out;
    always @(*) begin
        case (sel)
            3'd0: r_out = in0;
            3'd1: r_out = in1;
            3'd2: r_out = in2;
            3'd3: r_out = in3;
            3'd4: r_out = in4;
            3'd5: r_out = in5;
            default: r_out = 1'bx;
        endcase
    end
    assign out = r_out;
endmodule
