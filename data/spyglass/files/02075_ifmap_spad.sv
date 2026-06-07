module ifmap_spad(clk, addr, we, data_in, data_out);
    // 12 * 16bit
    input             clk;
    input      [3:0]  addr;
    input             we; // write enable signal, 0: Read; 1: Write
    input      [15:0] data_in;
    output reg [15:0] data_out;
    reg        [15:0] mem [11:0]; // 12 * 16bit
    // no X
    initial begin
        data_out = mem[addr];
    end
    always @ (negedge clk) begin
        if (we)
            mem[addr] <= data_in;
        else
            data_out <= mem[addr];
    end
endmodule
