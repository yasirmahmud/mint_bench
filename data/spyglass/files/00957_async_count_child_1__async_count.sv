module async_count (
    input j, k, clk, rst, output [3:0] q
);
    jkff j1(j, k, clk, rst, q[0]);
    jkff j2(j, k, q[0], rst, q[1]);
    jkff j3(j, k, q[1], rst, q[2]);
    jkff j4(j, k, q[2], rst, q[3]);
endmodule
