module interp_rom_3 (
    input CLK,
    input rst,
    input CEB,
    input [9:0] Addr,
    output reg [19:0] Q
);
    reg [19:0] rom_data [0:1023]; // 2^10 = 1024 words

    initial begin
        integer i;
        for (i = 0; i < 1024; i = i + 1) begin
            rom_data[i] = 20'd0; // Initialize with zeros
        end
    end

    always @(posedge CLK) begin
        if (rst) begin
            Q <= 20'd0;
        end else if (~CEB) begin // Active when CEB is low
            Q <= rom_data[Addr];
        end else begin
            Q <= 20'd0; // Output zero when ROM is disabled
        end
    end
endmodule
