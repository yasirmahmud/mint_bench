module tree_multiplier8  (A, B, product);

  input [7:0] A, B;
  output [15:0] product;

  wire [7:0] p[7:0];
  genvar i, j;

  generate
    for (i = 0; i < 8; i = i + 1) begin
      assign p[i] = A[i] ? B : 8'd0;
    end
  endgenerate

  wire [9:0] s1, s2, s3;
  wire [7:0] c1, c2, c3;
  wire [12:0] s4, s5, s6;
  wire [10:0] c4, c5, c6, c7;

  // Stage 1
  assign s1[0] = p[0][0];
  half_adder h0(p[0][1], p[1][0], s1[1], c1[0]);
  generate
    for (i = 2; i <= 7; i = i + 1) begin
      full_adder f1(p[0][i], p[1][i-1], p[2][i-2], s1[i], c1[i-1]);
    end
  endgenerate
  half_adder h1(p[1][7], p[2][6], s1[8], c1[7]);
  assign s1[9] = p[2][7];

  // Stage 2
  assign s2[0] = p[3][0];
  half_adder h2(p[3][1], p[4][0], s2[1], c2[0]);
  generate
    for (i = 2; i <= 7; i = i + 1) begin
      full_adder f2(p[3][i], p[4][i-1], p[5][i-2], s2[i], c2[i-1]);
    end
  endgenerate
  half_adder h3(p[4][7], p[5][6], s2[8], c2[7]);
  assign s2[9] = p[5][7];

  // Stage 3
  assign {s3[1:0], s3[2]} = {s1[1:0], c1[0]};
  generate
    for (i = 3; i <= 9; i = i + 1) begin
      full_adder f3(s1[i], c1[i-2], s2[i-3], s3[i], c3[i-2]);
    end
  endgenerate
  assign s3[10:12] = s2[7:9];

  // Stage 4
  assign {s4[3:0], s4[4]} = {s3[3:0], c3[0]};
  generate
    for (i = 5; i <= 12; i = i + 1) begin
      full_adder f4(s3[i], c3[i-4], c2[i-5], s4[i], c4[i-4]);
    end
  endgenerate

  // Stage 5
  assign s5[1:0] = c4[1:0];
  generate
    for (i = 2; i <= 10; i = i + 1) begin
      full_adder f5(p[6][i-3], p[7][i-4], c4[i-1], s5[i], c5[i-3]);
    end
  endgenerate

  // Stage 6
  assign s6[3:0] = s4[3:0];
  generate
    for (i = 4; i <= 14; i = i + 1) begin
      full_adder f6(s4[i], s5[i-6], c5[i-7], s6[i], c6[i-7]);
    end
  endgenerate

  // Final product
  assign product[4:0] = s6[4:0];
  generate
    for (i = 5; i <= 15; i = i + 1) begin
      full_adder f7(s6[i], c6[i-5], c7[i-6], product[i], c7[i-5]);
    end
  endgenerate
endmodule
