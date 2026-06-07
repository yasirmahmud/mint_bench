module curve_synth_89_20260111_201021_768716_w53504_attempt7 (
    input clk,
    input rst,
    output [7:0] data_out
);

    reg [7:0] my_register = 8'hAA; // This line triggers SYNTH_89

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            my_register <= 8'h00;
        end else begin
            my_register <= my_register + 1;
        end
    end

    assign data_out = my_register;

endmodule
