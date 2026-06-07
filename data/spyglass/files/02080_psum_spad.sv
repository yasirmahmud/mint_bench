module psum_spad(clk, addr, we, data_in,data_out);
    // 24 * 16bit
    input               clk;
    input       [4:0]   addr;
    input               we; // write enable signal, 0: Read; 1: Write
    input       [15:0]  data_in;
    output reg  [15:0]  data_out;
    reg         [15:0]  mem [23:0]; // 24 * 16bit
    //assign data_port = !we ? data_out : 16'bz;
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
