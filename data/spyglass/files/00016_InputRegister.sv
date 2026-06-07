module InputRegister  (
    input wire clk,
    input wire reset,
    input wire [31:0] A_in,
    input wire [31:0] B_in,
    input wire cin_in,
    output reg [31:0] A_out,
    output reg [31:0] B_out,
    output reg cin_out
);


    always @(posedge clk) begin
        if (reset) begin
            A_out <= 32'b0;
            B_out <= 32'b0;
            cin_out <= 1'b0;
        end else begin
            A_out <= A_in;
            B_out <= B_in;
            cin_out <= cin_out;
        end
    end

endmodule
