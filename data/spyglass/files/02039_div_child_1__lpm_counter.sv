module lpm_counter (
    input clock,
    output [0:0] q
);

    reg [0:0] count_reg = 1'b0; // Initialize for deterministic behavior

    always @(posedge clock) begin
        count_reg <= ~count_reg; // Toggles on each clock edge
    end

    assign q = count_reg;

endmodule
