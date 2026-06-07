module vedic4(p, q, out);
  input wire [3:0] p;
  input wire [3:0] q;
  output reg [7:0] out;
  wire [25:0] h;
  wire [7:0] k;
    vedic2x2 m0(p[1:0], q[1:0], h[3:0]);
    vedic2x2 m1(p[3:2], q[1:0], h[7:4]);
    vedic2x2 m2(p[1:0], q[3:2], h[11:8]);
    vedic2x2 m3(p[3:2], q[3:2], h[15:12]);
    ripplecarry m4(h[7:4], h[11:8], 1'b0, h[19:16], h[20]);
  assign k[0] = h[2];
  assign k[1] = h[3];
  assign k[2] = h[12];
  assign k[3] = h[13];
  assign out[0]=h[0];
  assign out[1]=h[1];  
ripplecarry m6(h[19:16],k[3:0],1'b0,out[5:2],h[21]):
halfadder m7( h[20],h[21],h[22],h[23]);
assign k[4]=h [22];
assign k[5]=h [23];
assign k[6]=h[14];                                           
assign k[7]=h[15];
ripplecarryl m8(k[7:6],k[5:4],1'b0,out[7:6],h(25:24]);   
endmodule
