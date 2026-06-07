module multi_decade (
    input clk, rstn, en,  
    output [3 : 0] ones, tens, hundreds,
    output done
);
    wire [3 : 0] Q [2 : 0];
    wire [2 : 0] en_signals, done_signals;

    // The original chaining logic for enable signals is preserved.
    // This correctly propagates the top-level enable (en) along with the completion signals (done_signals).
    // en_signals[0] = en
    // en_signals[1] = done_signals[0] & en_signals[0]
    // en_signals[2] = done_signals[1] & en_signals[1]
    assign en_signals = {(done_signals [1 : 0] & en_signals [1 : 0]), en};

    genvar i;
    generate
        for (i = 0; i < 3; i = i + 1) begin: Stage
            BCD_counter digit (.clk(clk), .rstn(rstn), .en(en_signals[i]), .Q(Q[i]), .done(done_signals[i]));
        end
    endgenerate

    assign hundreds = Q[2];
    assign tens = Q[1];
    assign ones = Q[0];
    // The overall 'done' is asserted when the hundreds counter completes its cycle AND it was enabled.
    assign done = done_signals[2] & en_signals[2];
endmodule
