module stage0 #(parameter p_inputWidth = 8,
                parameter p_PointPosition = 0
                )
                (
                input CLK,RST,
                ///// input signedS \\
                input signed [p_inputWidth-1 : 0] i_x0,
                input signed [p_inputWidth-1 : 0] i_x1,
                input signed [p_inputWidth-1 : 0] i_x2,
                input signed [p_inputWidth-1 : 0] i_x3,
                input signed [p_inputWidth-1 : 0] i_x4,
                input signed [p_inputWidth-1 : 0] i_x5,
                input signed [p_inputWidth-1 : 0] i_x6,
                input signed [p_inputWidth-1 : 0] i_x7,
                input signed [p_inputWidth-1 : 0] i_x8,
                input signed [p_inputWidth-1 : 0] i_x9,
                input signed [p_inputWidth-1 : 0] i_x10,
                input signed [p_inputWidth-1 : 0] i_x11,
                input signed [p_inputWidth-1 : 0] i_x12,
                input signed [p_inputWidth-1 : 0] i_x13,
                input signed [p_inputWidth-1 : 0] i_x14,
                input signed [p_inputWidth-1 : 0] i_x15,
                input signed [p_inputWidth-1 : 0] i_x16,
                input signed [p_inputWidth-1 : 0] i_x17,
                input signed [p_inputWidth-1 : 0] i_x18,
                input signed [p_inputWidth-1 : 0] i_x19,
                input signed [p_inputWidth-1 : 0] i_x20,
                input signed [p_inputWidth-1 : 0] i_x21,
                input signed [p_inputWidth-1 : 0] i_x22,
                input signed [p_inputWidth-1 : 0] i_x23,
                input signed [p_inputWidth-1 : 0] i_x24,
                input signed [p_inputWidth-1 : 0] i_x25,
                input signed [p_inputWidth-1 : 0] i_x26,
                input signed [p_inputWidth-1 : 0] i_x27,
                input signed [p_inputWidth-1 : 0] i_x28,
                input signed [p_inputWidth-1 : 0] i_x29,
                input signed [p_inputWidth-1 : 0] i_x30,
                input signed [p_inputWidth-1 : 0] i_x31,
                ///// OUTPUTS \\
                output signed [p_inputWidth : 0] o_a0,
                output signed [p_inputWidth : 0] o_a1,
                output signed [p_inputWidth : 0] o_a2,
                output signed [p_inputWidth : 0] o_a3,
                output signed [p_inputWidth : 0] o_a4,
                output signed [p_inputWidth : 0] o_a5,
                output signed [p_inputWidth : 0] o_a6,
                output signed [p_inputWidth : 0] o_a7,
                output signed [p_inputWidth : 0] o_a8,
                output signed [p_inputWidth : 0] o_a9,
                output signed [p_inputWidth : 0] o_a10,
                output signed [p_inputWidth : 0] o_a11,
                output signed [p_inputWidth : 0] o_a12,
                output signed [p_inputWidth : 0] o_a13,
                output signed [p_inputWidth : 0] o_a14,
                output signed [p_inputWidth : 0] o_a15,
                output signed [p_inputWidth : 0] o_a16,
                output signed [p_inputWidth : 0] o_a17,
                output signed [p_inputWidth : 0] o_a18,
                output signed [p_inputWidth : 0] o_a19,
                output signed [p_inputWidth : 0] o_a20,
                output signed [p_inputWidth : 0] o_a21,
                output signed [p_inputWidth : 0] o_a22,
                output signed [p_inputWidth : 0] o_a23,
                output signed [p_inputWidth : 0] o_a24,
                output signed [p_inputWidth : 0] o_a25,
                output signed [p_inputWidth : 0] o_a26,
                output signed [p_inputWidth : 0] o_a27,
                output signed [p_inputWidth : 0] o_a28,
                output signed [p_inputWidth : 0] o_a29,
                output signed [p_inputWidth : 0] o_a30,
                output signed [p_inputWidth : 0] o_a31
                  );
                  
                  wire [2*p_inputWidth - 1 : 0] w_x0,w_x1,w_x2,w_x3,w_x4,w_x5,w_x6,w_x7,w_x8,w_x9,
                                                w_x10,w_x11,w_x12,w_x13,w_x14,w_x15,w_x16,w_x17,w_x18,w_x19,
                                                w_x20,w_x21,w_x22,w_x23,w_x24,w_x25,w_x26,w_x27,w_x28,w_x29,w_x30,w_x31;
                                                
                 wire [2* (2*p_inputWidth - p_PointPosition) + 1 : 0] w_a0,w_a1,w_a2,w_a3,w_a4,w_a5,w_a6,w_a7,w_a8,w_a9,
                                                                      w_a10,w_a11,w_a12,w_a13,w_a14,w_a15,w_a16,w_a17,w_a18,w_a19,
                                                                      w_a20,w_a21,w_a22,w_a23,w_a24,w_a25,w_a26,w_a27,w_a28,w_a29,w_a30,w_a31;
                                               
                                               
                 // adding imaginary part = 0 as input is 8 bits integer (real)only
                 assign w_x0 =  {i_x0  , {(p_inputWidth){1'b0}} };
                 assign w_x1 =  {i_x1  , {(p_inputWidth){1'b0}} };
                 assign w_x2 =  {i_x2  , {(p_inputWidth){1'b0}} };
                 assign w_x3 =  {i_x3  , {(p_inputWidth){1'b0}} };
                 assign w_x4 =  {i_x4  , {(p_inputWidth){1'b0}} };
                 assign w_x5 =  {i_x5  , {(p_inputWidth){1'b0}} };
                 assign w_x6 =  {i_x6  , {(p_inputWidth){1'b0}} };
                 assign w_x7 =  {i_x7  , {(p_inputWidth){1'b0}} };
                 assign w_x8 =  {i_x8  , {(p_inputWidth){1'b0}} };
                 assign w_x9 =  {i_x9  , {(p_inputWidth){1'b0}} };
                 assign w_x10 = {i_x10 , {(p_inputWidth){1'b0}} };
                 assign w_x11 = {i_x11 , {(p_inputWidth){1'b0}} };
                 assign w_x12 = {i_x12 , {(p_inputWidth){1'b0}} };
                 assign w_x13 = {i_x13 , {(p_inputWidth){1'b0}} };
                 assign w_x14 = {i_x14 , {(p_inputWidth){1'b0}} };
                 assign w_x15 = {i_x15 , {(p_inputWidth){1'b0}} };
                 assign w_x16 = {i_x16 , {(p_inputWidth){1'b0}} };
                 assign w_x17 = {i_x17 , {(p_inputWidth){1'b0}} };
                 assign w_x18 = {i_x18 , {(p_inputWidth){1'b0}} };
                 assign w_x19 = {i_x19 , {(p_inputWidth){1'b0}} };
                 assign w_x20 = {i_x20 , {(p_inputWidth){1'b0}} };
                 assign w_x21 = {i_x21 , {(p_inputWidth){1'b0}} };
                 assign w_x22 = {i_x22 , {(p_inputWidth){1'b0}} };
                 assign w_x23 = {i_x23 , {(p_inputWidth){1'b0}} };
                 assign w_x24 = {i_x24 , {(p_inputWidth){1'b0}} };
                 assign w_x25 = {i_x25 , {(p_inputWidth){1'b0}} };
                 assign w_x26 = {i_x26 , {(p_inputWidth){1'b0}} };
                 assign w_x27 = {i_x27 , {(p_inputWidth){1'b0}} };
                 assign w_x28 = {i_x28 , {(p_inputWidth){1'b0}} };
                 assign w_x29 = {i_x29 , {(p_inputWidth){1'b0}} };
                 assign w_x30 = {i_x30 , {(p_inputWidth){1'b0}} };
                 assign w_x31 = {i_x31 , {(p_inputWidth){1'b0}} };
                 
                 // Local parameters to calculate the correct slicing indices for o_aX
                 // CPLX_PART_WIDTH_ST0 is the width of real or imaginary part from sharedComplexMUL outputs (w_aX)
                 localparam CPLX_PART_WIDTH_ST0 = (2*p_inputWidth - p_PointPosition) + 1;
                 // REAL_PART_MSB is the most significant bit index of the real part within w_aX
                 // w_aX is {real_part, imaginary_part}, each CPLX_PART_WIDTH_ST0 wide.
                 // So real part occupies [2*CPLX_PART_WIDTH_ST0 - 1 : CPLX_PART_WIDTH_ST0]
                 localparam REAL_PART_MSB = 2*CPLX_PART_WIDTH_ST0 - 1;
                 // O_A_WIDTH is the target width for o_aX
                 localparam O_A_WIDTH = p_inputWidth + 1;
                 // REAL_PART_SLICE_LSB is the least significant bit index to extract from the real part of w_aX
                 // to get O_A_WIDTH bits starting from REAL_PART_MSB.
                 localparam REAL_PART_SLICE_LSB = REAL_PART_MSB - O_A_WIDTH + 1;

                 // take the O_A_WIDTH bits from the most significant end of the real part of w_aX
                 // The original slice was [2* (2*p_inputWidth - p_PointPosition) - p_inputWidth + 1 : (2*p_inputWidth - p_PointPosition) + 1]
                 // This can lead to an inverted bit-select range if (p_inputWidth < p_PointPosition), causing a syntax error.
                 // The new calculation ensures HIGH >= LOW and extracts exactly O_A_WIDTH bits.
                 assign o_a0 = w_a0[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a1 = w_a1[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a2 = w_a2[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a3 = w_a3[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a4 = w_a4[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a5 = w_a5[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a6 = w_a6[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a7 = w_a7[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a8 = w_a8[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a9 = w_a9[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a10 = w_a10[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a11 = w_a11[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a12 = w_a12[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a13 = w_a13[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a14 = w_a14[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a15 = w_a15[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a16 = w_a16[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a17 = w_a17[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a18 = w_a18[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a19 = w_a19[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a20 = w_a20[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a21 = w_a21[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a22 = w_a22[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a23 = w_a23[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a24 = w_a24[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a25 = w_a25[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a26 = w_a26[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a27 = w_a27[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a28 = w_a28[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a29 = w_a29[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a30 = w_a30[REAL_PART_MSB : REAL_PART_SLICE_LSB];
                 assign o_a31 = w_a31[REAL_PART_MSB : REAL_PART_SLICE_LSB];

                 //------------------------------- MACS -------------------------------\n                  sharedComplexMUL #(.p_inputWidth(p_inputWidth), .p_PointPosition(p_PointPosition)) mac0
                  (
                  
                    .CLK(CLK),
                    .RST(RST),
                    
                    .i_m1(w_x1),
                    .i_m2(w_x3),
                    .i_m3(w_x5),
                    .i_m4(w_x7),
                    
                    .i_n1(w_x0),
                    .i_n2(w_x2),
                    .i_n3(w_x4),
                    .i_n4(w_x6),
                    
                    .i_l1(16'h0100),
                    .i_l2(16'h0100),
                    .i_l3(16'h0100),
                    .i_l4(16'h0100),
                    
                    .o_r1_p(w_a0),
                    .o_r1_m(w_a1),
                    .o_r2_p(w_a2),
                    .o_r2_m(w_a3),
                    .o_r3_p(w_a4),
                    .o_r3_m(w_a5),
                    .o_r4_p(w_a6),
                    .o_r4_m(w_a7)
                  );
                  
                  sharedComplexMUL #(.p_inputWidth(p_inputWidth), .p_PointPosition(p_PointPosition)) mac1
                  (
                  
                    .CLK(CLK),
                    .RST(RST),
                    
                    .i_m1(w_x9),
                    .i_m2(w_x11),
                    .i_m3(w_x13),
                    .i_m4(w_x15),
                    
                    .i_n1(w_x8),
                    .i_n2(w_x10),
                    .i_n3(w_x12),
                    .i_n4(w_x14),
                    
                    .i_l1(16'h0100),
                    .i_l2(16'h0100),
                    .i_l3(16'h0100),
                    .i_l4(16'h0100),
                    
                    .o_r1_p(w_a8),
                    .o_r1_m(w_a9),
                    .o_r2_p(w_a10),
                    .o_r2_m(w_a11),
                    .o_r3_p(w_a12),
                    .o_r3_m(w_a13),
                    .o_r4_p(w_a14),
                    .o_r4_m(w_a15)
                  );
                  
                  sharedComplexMUL #(.p_inputWidth(p_inputWidth), .p_PointPosition(p_PointPosition)) mac2
                  (
                  
                    .CLK(CLK),
                    .RST(RST),
                    
                    .i_m1(w_x17),
                    .i_m2(w_x19),
                    .i_m3(w_x21),
                    .i_m4(w_x23),
                    
                    .i_n1(w_x16),
                    .i_n2(w_x18),
                    .i_n3(w_x20),
                    .i_n4(w_x22),
                    
                    .i_l1(16'h0100),
                    .i_l2(16'h0100),
                    .i_l3(16'h0100),
                    .i_l4(16'h0100),
                    
                    .o_r1_p(w_a16),
                    .o_r1_m(w_a17),
                    .o_r2_p(w_a18),
                    .o_r2_m(w_a19),
                    .o_r3_p(w_a20),
                    .o_r3_m(w_a21),
                    .o_r4_p(w_a22),
                    .o_r4_m(w_a23)
                  );
                  
                  sharedComplexMUL #(.p_inputWidth(p_inputWidth), .p_PointPosition(p_PointPosition)) mac4
                  (
                  
                    .CLK(CLK),
                    .RST(RST),
                    
                    .i_m1(w_x25),
                    .i_m2(w_x27),
                    .i_m3(w_x29),
                    .i_m4(w_x31),
                    
                    .i_n1(w_x24),
                    .i_n2(w_x26),
                    .i_n3(w_x28),
                    .i_n4(w_x30),
                    
                    .i_l1(16'h0100),
                    .i_l2(16'h0100),
                    .i_l3(16'h0100),
                    .i_l4(16'h0100),
                    
                    .o_r1_p(w_a24),
                    .o_r1_m(w_a25),
                    .o_r2_p(w_a26),
                    .o_r2_m(w_a27),
                    .o_r3_p(w_a28),
                    .o_r3_m(w_a29),
                    .o_r4_p(w_a30),
                    .o_r4_m(w_a31)
                  );
                  
endmodule
