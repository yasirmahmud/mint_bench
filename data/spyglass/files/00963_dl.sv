module dl (
    input d, en, output reg q
);
    always @(en, d) begin
        if(en)
        q <= d;
    end
endmodule
