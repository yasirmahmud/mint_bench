module ifft4 #(
    parameter DATA_WIDTH = 8    
)
(
    input wire clk,
    input wire rst_n,
    input wire en,

    // 4ç‚¹çš„FFT,å››ä¸ªè¾“å…¥å®žéƒ¨å’Œè™šéƒ¨
    input  wire signed [DATA_WIDTH-1:0] in0_real,
    input  wire signed [DATA_WIDTH-1:0] in0_imag,
    input  wire signed [DATA_WIDTH-1:0] in1_real,
    input  wire signed [DATA_WIDTH-1:0] in1_imag,
    input  wire signed [DATA_WIDTH-1:0] in2_real,
    input  wire signed [DATA_WIDTH-1:0] in2_imag,
    input  wire signed [DATA_WIDTH-1:0] in3_real,
    input  wire signed [DATA_WIDTH-1:0] in3_imag,

    // 4ç‚¹çš„FFTéœ€è¦ è¿›è¡Œä¸¤å±‚Butterfly, å› æ­¤ä¸ºå…¶å¤šå¯Œä½™ä¸¤ä¸ªä½ å®½
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
    // 1 << 9 = 512 æ•…ä¸‹é ¢çš„æ—‹è½¬å› å­ å ‚æ•°ä¹Ÿè¢«æ‰©å¤§äº†512å€ 
    localparam EXPAND = 9;
    // å››ç‚¹fft
    localparam POINTS = 4; 

    // æ—‹è½¬å› å­  (Replaced original RO_ARRAY reg and initial block for synthesizability)
    // This resolves SYNTH_5143 violation.
    localparam signed [EXPAND+1:0] RO_0_REAL = 512;
    localparam signed [EXPAND+1:0] RO_0_IMAG = 0;
    localparam signed [EXPAND+1:0] RO_1_REAL = 0;
    localparam signed [EXPAND+1:0] RO_1_IMAG = 512;

    // ç”¨äºŽåŽŸå§‹æ•°æ ®å±‚å’Œç¬¬ä¸€è®¡ç®—å±‚
    wire signed [DATA_WIDTH-1:0] in_real[3:0];
    wire signed [DATA_WIDTH-1:0] in_imag[3:0];
    // ç”¨äºŽç¬¬ä¸€è®¡ç®—å±‚å’Œç¬¬äºŒè®¡ç®—å±‚
    wire signed signed [DATA_WIDTH+0:0] in_real_step1[3:0];
    wire signed signed [DATA_WIDTH+0:0] in_imag_step1[3:0];
    // ç”¨äºŽç¬¬äºŒè®¡ç®—å±‚å’Œè¾“å‡ºå±‚
    wire signed signed [DATA_WIDTH+1:0] in_real_step2[3:0];
    wire signed signed [DATA_WIDTH+1:0] in_imag_step2[3:0];
    // ç”¨äºŽè¿žæŽ¥å „ä¸ªæ¨¡å —çš„enå¼•è„š

    wire en_connect [3:0][1:0];
    //  è¿žæŽ¥å¼•è„šç¬¬ä¸€å±‚è ¶å½¢è¿ ç®—æ¨¡å —
    assign en_connect[0][0] = en;
    assign en_connect[1][0] = en;
    // ç¬¬ä¸€æ­¥: ç  ä½ å€’ç½®
    assign in_real[0] = in0_real;
    assign in_imag[0] = in0_imag;
    assign in_real[1] = in2_real;
    assign in_imag[1] = in2_imag;
    assign in_real[2] = in1_real;
    assign in_imag[2] = in1_imag;
    assign in_real[3] = in3_real;
    assign in_imag[3] = in3_imag;

    //  ç¬¬äºŒæ­¥: è¿žæŽ¥å€’ç½®å Žçš„æ•°æ ®å’Œç¬¬ä¸€å±‚è ¶å½¢è¿ ç®—
    Butterfly #(
        .DATA_WIDTH(DATA_WIDTH), .EXPAND(EXPAND)
    )  butterfly_unit_0_0 (
            // æŽ§åˆ¶ä¿¡å ·
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[0][0]),
            // è¾“å…¥ 
            .in1_real(in_real[0]),
            .in1_imag(in_imag[0]),
            .in2_real(in_real[1]),
            .in2_imag(in_imag[1]),
            // æ—‹è½¬å› å­ 
            .ro_real(RO_0_REAL),
            .ro_imag(RO_0_IMAG),
            // è¾“å‡º
            .out1_real(in_real_step1[0]),
            .out1_imag(in_imag_step1[0]),
            .out2_real(in_real_step1[1]),
            .out2_imag(in_imag_step1[1]),
            // è¾“å‡ºæ˜¯å ¦æœ‰æ•ˆä¿¡å ·
            // æœ‰æ•ˆä»£è¡¨è¯¥æ•°æ ®å ¯ç”¨,å ¦åˆ™åˆ™ä¸ å ¯ç”¨
            .valid(en_connect[0][1])
    );

    Butterfly #(
        .DATA_WIDTH(DATA_WIDTH), .EXPAND(EXPAND)
    )  butterfly_unit_0_1 (
            // æŽ§åˆ¶ä¿¡å ·
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[1][0]),
            // è¾“å…¥ 
            .in1_real(in_real[2]),
            .in1_imag(in_imag[2]),
            .in2_real(in_real[3]),
            .in2_imag(in_imag[3]),
            // æ—‹è½¬å› å­ 
            .ro_real(RO_0_REAL),
            .ro_imag(RO_0_IMAG),
            // è¾“å‡º
            .out1_real(in_real_step1[2]),
            .out1_imag(in_imag_step1[2]),
            .out2_real(in_real_step1[3]),
            .out2_imag(in_imag_step1[3]),
            // è¾“å‡ºæ˜¯å ¦æœ‰æ•ˆä¿¡å ·
            // æœ‰æ•ˆä»£è¡¨è¯¥æ•°æ ®å ¯ç”¨,å ¦åˆ™åˆ™ä¸ å ¯ç”¨
            .valid(en_connect[1][1])
    );
    
    //  è¿žæŽ¥ç¬¬ä¸€å±‚è ¶å½¢è¿ ç®—æ¨¡å —validå’Œç¬¬äºŒå±‚è ¶å½¢è¿ ç®—æ¨¡å —en
    assign en_connect[2][0] = en_connect[0][1];
    assign en_connect[3][0] = en_connect[1][1];

    // ç¬¬äºŒå±‚è ¶å½¢è¿ ç®—
    Butterfly #(
        .DATA_WIDTH(DATA_WIDTH+1), .EXPAND(EXPAND)
    )  butterfly_unit_1_0 (
            // æŽ§åˆ¶ä¿¡å ·
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[2][0]),
            // è¾“å…¥ 
            .in1_real(in_real_step1[0]),
            .in1_imag(in_imag_step1[0]),
            .in2_real(in_real_step1[2]),
            .in2_imag(in_imag_step1[2]),
            // æ—‹è½¬å› å­ 
            .ro_real(RO_0_REAL),
            .ro_imag(RO_0_IMAG),
            // è¾“å‡º
            .out1_real(in_real_step2[0]),
            .out1_imag(in_imag_step2[0]),
            .out2_real(in_real_step2[2]),
            .out2_imag(in_imag_step2[2]),
            // è¾“å‡ºæ˜¯å ¦æœ‰æ•ˆä¿¡å ·
            // æœ‰æ•ˆä»£è¡¨è¯¥æ•°æ ®å ¯ç”¨,å ¦åˆ™åˆ™ä¸ å ¯ç”¨
            .valid(en_connect[2][1])
    );

    Butterfly #(
        .DATA_WIDTH(DATA_WIDTH+1), .EXPAND(EXPAND)
    )  butterfly_unit_1_1 (
            // æŽ§åˆ¶ä¿¡å ·
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[3][0]),
            // è¾“å…¥ 
            .in1_real(in_real_step1[1]),
            .in1_imag(in_imag_step1[1]),
            .in2_real(in_real_step1[3]),
            .in2_imag(in_imag_step1[3]),
            // æ—‹è½¬å› å­ 
            .ro_real(RO_1_REAL),
            .ro_imag(RO_1_IMAG),
            // è¾“å‡º
            .out1_real(in_real_step2[1]),
            .out1_imag(in_imag_step2[1]),
            .out2_real(in_real_step2[3]),
            .out2_imag(in_imag_step2[3]),
            // è¾“å‡ºæ˜¯å ¦æœ‰æ•ˆä¿¡å ·
            // æœ‰æ•ˆä»£è¡¨è¯¥æ•°æ ®å ¯ç”¨,å ¦åˆ™åˆ™ä¸ å ¯ç”¨
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
