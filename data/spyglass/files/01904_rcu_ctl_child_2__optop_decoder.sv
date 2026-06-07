// Dummy module for optop_decoder
module optop_decoder (
    input [15:0] opcode,
    input valid,
    input second_cyc,
    input group_3_r,
    input group_5_r,
    input group_6_r,
    output [4:0] net_optop_sel1,
    output [3:0] net_optop_sel2,
    output [1:0] net_optop_sel
);
    assign net_optop_sel1 = 5'b0;
    assign net_optop_sel2 = 4'b0;
    assign net_optop_sel = 2'b0;
endmodule
