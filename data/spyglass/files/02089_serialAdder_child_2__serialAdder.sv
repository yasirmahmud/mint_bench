module serialAdder( i_clk, i_rst, i_a, i_b, o_sum);

parameter DATAWIDTH = 8;

input wire i_clk, i_rst;
input wire [DATAWIDTH-1:0] i_a, i_b;
output reg [DATAWIDTH-1:0] o_sum;

reg i_shift, i_load;
wire [DATAWIDTH-1:0] o_rega, o_regb;

wire o_regc;
wire o_and, dff_in, dff_out;

// Wrap entire code over a counter of DATAWIDTH bits

reg [DATAWIDTH:0] counter;

// module instantiations
shiftReg #( .DATAWIDTH(DATAWIDTH) ) A(i_clk, i_rst, i_shift, i_load, i_a, o_rega);
shiftReg #( .DATAWIDTH(DATAWIDTH) ) B(i_clk, i_rst, i_shift, i_load, i_b, o_regb);

fullAdder C(o_rega[0], o_regb[0], dff_out, o_regc, dff_in);

dff D(o_and, i_rst, dff_in, dff_out);

andGate AND(i_shift, i_clk, o_and);

always @(posedge i_clk or negedge i_rst) 
    if (!i_rst)  
    begin
        counter <= DATAWIDTH+2;
        i_shift <= 0;
        i_load <= 0;
        o_sum <= 0;
    end
    else if (counter == DATAWIDTH+2)
    begin
        i_load <= 1;
        i_shift <= 0;
        counter <= counter - 1;
    end
    else if (counter != 0)
    begin
        i_load <= 0;
        i_shift <= 1;
        o_sum <= {o_regc, o_sum[DATAWIDTH-1:1]};
        counter <= counter - 1;
    }
    else
    begin
        i_load <= 0;
        i_shift <= 0;
        counter <= DATAWIDTH+2;
        o_sum <= 0;
    end

endmodule
