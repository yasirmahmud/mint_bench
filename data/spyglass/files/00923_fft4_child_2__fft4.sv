module fft4 #(
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

    output wire yout_valid
);
    wire valid;
    assign yout_valid = valid;
    // 1 << 9 = 512 æ•…ä¸‹é ¢çš„æ—‹è½¬å› å­ å ‚æ•°ä¹Ÿè¢«æ‰©å¤§äº†512å€ 
    localparam EXPAND = 9;
    // å››ç‚¹fft
    localparam POINTS = 4; 

    // æ—‹è½¬å› å­  (Twiddle factors)
    // Replaced reg array with localparams to resolve SYNTH_5143 and ELAB_3519.
    // Only W0 and W1 are actually used in the current butterfly instantiations.
    localparam signed [EXPAND+1:0] TWIDDLE_W0_REAL = 512; // RO_ARRAY[0][0]
    localparam signed [EXPAND+1:0] TWIDDLE_W0_IMAG = 0;  // RO_ARRAY[0][1]
    localparam signed [EXPAND+1:0] TWIDDLE_W1_REAL = 0;  // RO_ARRAY[1][0]
    localparam signed [EXPAND+1:0] TWIDDLE_W1_IMAG = -512; // RO_ARRAY[1][1]
    
    // Unused twiddle factors (RO_ARRAY[2][x] and RO_ARRAY[3][x]) are omitted as they are not instantiated.


    // å››ç‚¹çš„fftå…±éœ€è¦ ä¸‰å±‚è¿žçº¿:ç  ä½ å€’ç½®ä¸€å±‚,ç¬¬ä¸€æ¬¡è ¶å½¢è¿ ç®—ä¸€å±‚,ç¬¬äºŒæ¬¡è ¶å½¢è¿ ç®—ä¸€å±‚
    // [DATA_WIDTH+EXPAND-1:0]è¡¨ç¤ºæ¯ ä¸ªæ•°æ ®çš„ä½ å®½
    // [2:0]è¡¨ç¤º å…±éœ€è¦ ä¸‰å±‚
    // [3:0]è¡¨ç¤ºæ¯ ä¸ªå±‚æœ‰å››ä¸ªæ•°æ ®,å ³å››ç‚¹çš„æ•°æ ®
    // wire signed [DATA_WIDTH+EXPAND-1:0] in_real[2:0][3:0];
    // wire signed [DATA_WIDTH+EXPAND-1:0] in_imag[2:0][3:0];

    // ç”¨äºŽåŽŸå§‹æ•°æ ®å±‚å’Œç¬¬ä¸€è®¡ç®—å±‚
    wire signed [DATA_WIDTH-1:0] in_real[3:0];
    wire signed [DATA_WIDTH-1:0] in_imag[3:0];
    // ç”¨äºŽç¬¬ä¸€è®¡ç®—å±‚å’Œç¬¬äºŒè®¡ç®—å±‚
    // Outputs of first stage Butterflies, DATA_WIDTH+2 bits wide as per Butterfly module's output width
    wire signed [DATA_WIDTH+1:0] in_real_step1[3:0];
    wire signed [DATA_WIDTH+1:0] in_imag_step1[3:0];
    // ç”¨äºŽç¬¬äºŒè®¡ç®—å±‚å’Œè¾“å‡ºå±‚
    // Outputs of second stage Butterflies are DATA_WIDTH + 4 bits wide internally. 
    // W110 fixed: Adjusted width to match Butterfly module's output when DATA_WIDTH param is (DATA_WIDTH+2).
    wire signed [DATA_WIDTH+3:0] in_real_step2[3:0];
    wire signed [DATA_WIDTH+3:0] in_imag_step2[3:0];
    // ç”¨äºŽè¿žæŽ¥å „ä¸ªæ¨¡å —çš„enå¼•è„š

    wire en_connect [3:0][1:0];
    //  è¿žæŽ¥å¼•è„šç¬¬ä¸€å±‚è ¶å½¢è¿ ç®—æ¨¡å —
    assign en_connect[0][0] = en;
    assign en_connect[1][0] = en;
    // ç¬¬ä¸€æ­¥: ç  ä½ å€’ç½® (Bit reversal)
    assign in_real[0] = in0_real;
    assign in_imag[0] = in0_imag;
    assign in_real[1] = in2_real;
    assign in_imag[1] = in2_imag;
    assign in_real[2] = in1_real;
    assign in_imag[2] = in1_imag;
    assign in_real[3] = in3_real;
    assign in_imag[3] = in3_imag;

    //  ç¬¬äºŒæ­¥: è¿žæŽ¥å€’ç½®å Žçš„æ•°æ ®å’Œç¬¬ä¸€å±‚è ¶å½¢è¿ ç®—
    Butterfly #( // First stage butterfly units
        .DATA_WIDTH(DATA_WIDTH), // Input data width is DATA_WIDTH
        .EXPAND(EXPAND)
    )  butterfly_unit_0_0 (
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[0][0]),
            .in1_real(in_real[0]),
            .in1_imag(in_imag[0]),
            .in2_real(in_real[1]),
            .in2_imag(in_imag[1]),
            .ro_real(TWIDDLE_W0_REAL), // Uses W0
            .ro_imag(TWIDDLE_W0_IMAG),
            .out1_real(in_real_step1[0]),
            .out1_imag(in_imag_step1[0]),
            .out2_real(in_real_step1[1]),
            .out2_imag(in_imag_step1[1]),
            .valid(en_connect[0][1])
    );

    Butterfly #( // First stage butterfly units
        .DATA_WIDTH(DATA_WIDTH),
        .EXPAND(EXPAND)
    )  butterfly_unit_0_1 (
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[1][0]),
            .in1_real(in_real[2]),
            .in1_imag(in_imag[2]),
            .in2_real(in_real[3]),
            .in2_imag(in_imag[3]),
            .ro_real(TWIDDLE_W0_REAL), // Uses W0
            .ro_imag(TWIDDLE_W0_IMAG),
            .out1_real(in_real_step1[2]),
            .out1_imag(in_imag_step1[2]),
            .out2_real(in_real_step1[3]),
            .out2_imag(in_imag_step1[3]),
            .valid(en_connect[1][1])
    );
    
    //  è¿žæŽ¥ç¬¬ä¸€å±‚è ¶å½¢è¿ ç®—æ¨¡å —validå’Œç¬¬äºŒå±‚è ¶å½¢è¿ ç®—æ¨¡å —en
    assign en_connect[2][0] = en_connect[0][1];
    assign en_connect[3][0] = en_connect[1][1];

    // ç¬¬äºŒå±‚è ¶å½¢è¿ ç®— (Second stage butterfly units)
    Butterfly #(
        // W110 fixed: Input data width for second stage is DATA_WIDTH+2 from previous stage outputs.
        .DATA_WIDTH(DATA_WIDTH+2), 
        .EXPAND(EXPAND)
    )  butterfly_unit_1_0 (
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[2][0]),
            .in1_real(in_real_step1[0]),
            .in1_imag(in_imag_step1[0]),
            .in2_real(in_real_step1[2]),
            .in2_imag(in_imag_step1[2]),
            .ro_real(TWIDDLE_W0_REAL), // Uses W0
            .ro_imag(TWIDDLE_W0_IMAG),
            .out1_real(in_real_step2[0]),
            .out1_imag(in_imag_step2[0]),
            .out2_real(in_real_step2[2]),
            .out2_imag(in_imag_step2[2]),
            .valid(en_connect[2][1])
    );

    Butterfly #(
        // W110 fixed: Input data width for second stage is DATA_WIDTH+2 from previous stage outputs.
        .DATA_WIDTH(DATA_WIDTH+2), 
        .EXPAND(EXPAND)
    )  butterfly_unit_1_1 (
            .clk(clk),
            .rst_n(rst_n),
            .en(en_connect[3][0]),
            .in1_real(in_real_step1[1]),
            .in1_imag(in_imag_step1[1]),
            .in2_real(in_real_step1[3]),
            .in2_imag(in_imag_step1[3]),
            .ro_real(TWIDDLE_W1_REAL), // Uses W1
            .ro_imag(TWIDDLE_W1_IMAG),
            .out1_real(in_real_step2[1]),
            .out1_imag(in_imag_step2[1]),
            .out2_real(in_real_step2[3]),
            .out2_imag(in_imag_step2[3]),
            .valid(en_connect[3][1])
    );

    // The overall output valid signal is active when the last stage provides valid data
    assign valid = en_connect[3][1];

    // W110 fixed: Explicitly truncate outputs to match the specified fft4 output port width (DATA_WIDTH+2).
    assign out0_real = in_real_step2[DATA_WIDTH+1:0];
    assign out0_imag = in_imag_step2[DATA_WIDTH+1:0];
    assign out1_real = in_real_step2[DATA_WIDTH+1:0];
    assign out1_imag = in_imag_step2[DATA_WIDTH+1:0];
    assign out2_real = in_real_step2[DATA_WIDTH+1:0];
    assign out2_imag = in_imag_step2[DATA_WIDTH+1:0];
    assign out3_real = in_real_step2[DATA_WIDTH+1:0];
    assign out3_imag = in_imag_step2[DATA_WIDTH+1:0];

endmodule
