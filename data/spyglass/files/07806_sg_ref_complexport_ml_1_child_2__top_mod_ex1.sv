module top_mod_ex1 (
    input clk,
    input rst_n
);
    reg [7:0] my_signal;

    // SYNTH_5143: Initial block is ignored for synthesis. Replaced with synthesizable reset logic.
    // UndrivenInTerm-ML: 'my_signal' is now driven by an always block.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin // Active low reset
            my_signal <= 8'hAA;
        end else begin
            // my_signal retains its value when not explicitly updated,
            // ensuring it is always driven for synthesis tools.
            my_signal <= my_signal;
        end
    end

    // Instance sub_mod, connecting data_in and the dummy output port.
    sub_mod inst1 (
        .data_in (my_signal[3:0]),
        .unused_signal_out () // Dummy output, left unconnected to preserve functional behavior
    );
endmodule
