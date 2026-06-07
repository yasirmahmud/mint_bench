module Port_control_logic (
    input  wire       MSTR,
    input  wire       SCK_out,
    input  wire       Data_out,
    input  wire       SS_master,
    inout  wire       MOSI,
    inout  wire       MISO,
    inout  wire       SCK,
    inout  wire       SS,
    output wire       SCK_in,
    output wire       Data_in
);
    // Master drives outputs, slave listens to inputs
    assign SCK = MSTR ? SCK_out : 1'bz;
    assign MOSI = MSTR ? Data_out : 1'bz;
    assign SS = MSTR ? SS_master : 1'bz;
    assign MISO = MSTR ? 1'bz : 1'bz; // Slave drives MISO, but for dummy just high-Z

    assign SCK_in = SCK; // Slave clock input
    assign Data_in = MOSI; // Slave data input
endmodule
