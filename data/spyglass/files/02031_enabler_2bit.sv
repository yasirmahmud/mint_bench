module enabler_2bit(
    input wire en, rst,
    input wire [1:0] in0,
    output reg [1:0] out0
    );
    always @(*) begin 
        if(rst)begin
            out0 <= 2'b00;
        end else begin
            if (en) begin
                out0 <= in0;
            end else begin
                out0 <= out0;
            end
        end
    end
endmodule
