module uni_s_r (
    input [3:0] i, input [1:0] s, input sr, sl, input clk, rst, output [3:0] a, output sr_out, sl_out
);
    wire j1, j2, j3, j4, o1, o2, o3, o4;
    
    mux4to1 m1({
        i[3], o2, sr, o1
    }, s, j1);
    dff d1(j1, clk, rst, o1);

    mux4to1 m2({
        i[2], o3, o1, o2
    }, s, j2);
    dff d2(j2, clk, rst, o2);

    mux4to1 m3({
        i[1], o4, o2, o3
    }, s, j3);
    dff d3(j3, clk, rst, o3);

    mux4to1 m4({
        i[0], sl, o3, o4
    }, s, j4);
    dff d4(j4, clk, rst, o4);

    assign sl_out = o1;
    assign sr_out = o4;

    assign a[3] = o1 & (s[1] & s[0]);
    assign a[2] = o2 & (s[1] & s[0]);
    assign a[1] = o3 & (s[1] & s[0]);
    assign a[0] = o4 & (s[1] & s[0]);    
endmodule
