module ifft4 #(
    parameter DATA_WIDTH = 8    
)
(
    input wire clk,
    input wire rst_n,
    input wire en,

    // 4ç¹çFFT,åä¸ªè¾å¥å®é¨åèé¨
    input  wire signed [DATA_WIDTH-1:0] in0_real,
    input  wire signed [DATA_WIDTH-1:0] in0_imag,
    input  wire signed [DATA_WIDTH-1:0] in1_real,
    input  wire signed [DATA_WIDTH-1:0] in1_imag,
    input  wire signed [DATA_WIDTH-1:0] in2_real,
    input  wire signed [DATA_WIDTH-1:0] in2_imag,
    input  wire signed [DATA_WIDTH-1:0] in3_real,
    input  wire signed [DATA_WIDTH-1:0] in3_imag,

    // 4ç¹çFFTéè¦è¿è¡ä¸¤å±Butterfly, å æ­¤ä¸ºå¶å¤å¯ä½ä¸¤ä¸ªä½å®½
    output wire signed [DATA_WIDTH+1:0] out0_real,
    output wire signed [DATA_WIDTH+1:0] out0_imag,
    output wire signed [DATA_WIDTH+1:0] out1_real,
    output wire signed [DATA_WIDTH+1:0] out1_imag,
    output wire signed [DATA_WIDTH+1:0] out2_real,
    output wire signed [DATA_WIDTH+1:0] out2_imag,
    output wire signed [DATA_WIDTH+1:0] out3_real,
    output wire signed [DATA_WIDTH+1:0] out3_imag,

    output wire valid
);
    // 1 << 9 = 512 æä¸é¢çæè½¬å å­åæ°ä¹è¢«æ©å¤§äº512å
    localparam EXPAND = 9;
    // åç¹fft
    localparam POINTS = 4; 

    // æè½¬å å­ 
    reg signed [EXPAND+1:0] RO_ARRAY[POINTS-1:0][1:0];
    // åå§åæè½¬å å­
    initial begin
        RO_ARRAY[0][0] <= 512;
        RO_ARRAY[0][1] <= 0;
        RO_ARRAY[1][0] <= 0; 
        RO_ARRAY[1][1] <= 512; 
        RO_ARRAY[2][0] <= -512;
        RO_ARRAY[2][1] <= 0;
        RO_ARRAY[3][0] <= 0; 
        RO_ARRAY[3][1] <= -512;
    end



    // åç¹çfftå±éè¦ä¸å±è¿çº¿:ç ä½åç½®ä¸å±,ç¬¬ä¸æ¬¡è¶å½¢è¿ç®ä¸å±,ç¬¬äºæ¬¡è¶å½¢è¿ç®ä¸å±
    // [DATA_WIDTH+EXPAND-1:0]è¡¨ç¤ºæ¯ä¸ªæ°æ®çä½å®½
    // [2:0]è¡¨ç¤º å±éè¦ä¸å±
    // [3:0]è¡¨ç¤ºæ¯ä¸ªå±æåä¸ªæ°æ®,å³åç¹çæ°æ®
    // wire signed [DATA_WIDTH+EXPAND-1:0] in_real[2:0][3:0];
    // wire signed [DATA_WIDTH+EXPAND-1:0] in_imag[2:0][3:0];

    // ç¨äºåå§æ°æ®å±åç¬¬ä¸è®¡ç®å±
    wire signed [DATA_WIDTH-1:0] in_real[3:0];
    wire signed [DATA_WIDTH-1:0] in_imag[3:0];
    // ç¨äºç¬¬ä¸è®¡ç®å±åç¬¬äºè®¡ç®å±
    wire signed [DATA_WIDTH+0:0] in_real_step1[3:0];
    wire signed [DATA_WIDTH+0:0] in_imag_step1[3:0];
    // ç¨äºç¬¬äºè®¡ç®å±åè¾åºå±
    wire signed [DATA_WIDTH+1:0] in_real_step2[3:0];
    wire signed [DATA_WIDTH+1:0] in_imag_step2[3:0];
    // ç¨äºè¿æ¥åä¸ªæ¨¡åçenå¼è

    wire en_connect [3:0][1:0];
    //  è¿æ¥å¼èç¬¬ä¸å±è¶å½¢è¿ç®æ¨¡å
    assign en_connect[0][0] = en;
    assign en_connect[1][0] = en;
    // ç¬¬ä¸æ­¥: ç ä½åç½®
    assign in_real[0] = in0_real;
    assign in_imag[0] = in0_imag;
    assign in_real[1] = in2_real;
    assign in_imag[1] = in2_imag;
    assign in_real[2] = in1_real;
    assign in_imag[2] = in1_imag;
    assign in_real[3] = in3_real;
    assign in_imag[3] = in3_imag;

    //  ç¬¬äºæ­¥: è¿æ¥åç½®åçæ°æ®åç¬¬ä¸å±è¶å½¢è¿ç®
    Butterfly #(
        .DATA_WIDTH(DATA_WIDTH), .EXPAND(EXPAND)
    )  butterfly_unit_0_0 (
            // æ§å¶ä¿¡å·
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[0][0]),
            // è¾å¥ 
            .in1_real(in_real[0]),
            .in1_imag(in_imag[0]),
            .in2_real(in_real[1]),
            .in2_imag(in_imag[1]),
            // æè½¬å å­
            .ro_real(RO_ARRAY[0][0]),
            .ro_imag(RO_ARRAY[0][1]),
            // è¾åº
            .out1_real(in_real_step1[0]),
            .out1_imag(in_imag_step1[0]),
            .out2_real(in_real_step1[1]),
            .out2_imag(in_imag_step1[1]),
            // è¾åºæ¯å¦ææä¿¡å·
            // ææä»£è¡¨è¯¥æ°æ®å¯ç¨,å¦ååä¸å¯ç¨
            .valid(en_connect[0][1])
    );

    Butterfly #(
        .DATA_WIDTH(DATA_WIDTH), .EXPAND(EXPAND)
    )  butterfly_unit_0_1 (
            // æ§å¶ä¿¡å·
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[1][0]),
            // è¾å¥ 
            .in1_real(in_real[2]),
            .in1_imag(in_imag[2]),
            .in2_real(in_real[3]),
            .in2_imag(in_imag[3]),
            // æè½¬å å­
            .ro_real(RO_ARRAY[0][0]),
            .ro_imag(RO_ARRAY[0][1]),
            // è¾åº
            .out1_real(in_real_step1[2]),
            .out1_imag(in_imag_step1[2]),
            .out2_real(in_real_step1[3]),
            .out2_imag(in_imag_step1[3]),
            // è¾åºæ¯å¦ææä¿¡å·
            // ææä»£è¡¨è¯¥æ°æ®å¯ç¨,å¦ååä¸å¯ç¨
            .valid(en_connect[1][1])
    );
    
    //  è¿æ¥ç¬¬ä¸å±è¶å½¢è¿ç®æ¨¡åvalidåç¬¬äºå±è¶å½¢è¿ç®æ¨¡åen
    assign en_connect[2][0] = en_connect[0][1];
    assign en_connect[3][0] = en_connect[1][1];

    // ç¬¬äºå±è¶å½¢è¿ç®
    Butterfly #(
        .DATA_WIDTH(DATA_WIDTH+1), .EXPAND(EXPAND)
    )  butterfly_unit_1_0 (
            // æ§å¶ä¿¡å·
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[2][0]),
            // è¾å¥ 
            .in1_real(in_real_step1[0]),
            .in1_imag(in_imag_step1[0]),
            .in2_real(in_real_step1[2]),
            .in2_imag(in_imag_step1[2]),
            // æè½¬å å­
            .ro_real(RO_ARRAY[0][0]),
            .ro_imag(RO_ARRAY[0][1]),
            // è¾åº
            .out1_real(in_real_step2[0]),
            .out1_imag(in_imag_step2[0]),
            .out2_real(in_real_step2[2]),
            .out2_imag(in_imag_step2[2]),
            // è¾åºæ¯å¦ææä¿¡å·
            // ææä»£è¡¨è¯¥æ°æ®å¯ç¨,å¦ååä¸å¯ç¨
            .valid(en_connect[2][1])
    );

    Butterfly #(
        .DATA_WIDTH(DATA_WIDTH+1), .EXPAND(EXPAND)
    )  butterfly_unit_1_1 (
            // æ§å¶ä¿¡å·
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[3][0]),
            // è¾å¥ 
            .in1_real(in_real_step1[1]),
            .in1_imag(in_imag_step1[1]),
            .in2_real(in_real_step1[3]),
            .in2_imag(in_imag_step1[3]),
            // æè½¬å å­
            .ro_real(RO_ARRAY[1][0]),
            .ro_imag(RO_ARRAY[1][1]),
            // è¾åº
            .out1_real(in_real_step2[1]),
            .out1_imag(in_imag_step2[1]),
            .out2_real(in_real_step2[3]),
            .out2_imag(in_imag_step2[3]),
            // è¾åºæ¯å¦ææä¿¡å·
            // ææä»£è¡¨è¯¥æ°æ®å¯ç¨,å¦ååä¸å¯ç¨
            .valid(en_connect[3][1])
    );

    assign valid = en_connect[3][1];

    assign out0_real = in_real_step2[0] >>> 2;
    assign out0_imag = in_imag_step2[0] >>> 2;
    assign out1_real = in_real_step2[1] >>> 2;
    assign out1_imag = in_imag_step2[1] >>> 2;
    assign out2_real = in_real_step2[2] >>> 2;
    assign out2_imag = in_imag_step2[2] >>> 2;
    assign out3_real = in_real_step2[3] >>> 2;
    assign out3_imag = in_imag_step2[3] >>> 2;

endmodule
