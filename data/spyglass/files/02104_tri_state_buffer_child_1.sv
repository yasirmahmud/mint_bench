module tri_state_buffer(
    parameter WIDTH = 8,
    input [WIDTH-1:0]data_in,
    input en,
    output reg [WIDTH-1:0]data_out
    );
    always @ (*)
    begin
        if(en) begin
            data_out = data_in;
        end
        else begin
            data_out = 'bz;
        end
    end
endmodule
