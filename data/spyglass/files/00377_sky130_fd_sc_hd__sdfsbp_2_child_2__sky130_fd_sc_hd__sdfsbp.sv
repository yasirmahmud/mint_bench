module sky130_fd_sc_hd__sdfsbp (
    output Q,
    output Q_N,
    input CLK,
    input D,
    input SCD,
    input SCE,
    input SET_B
);

    reg q_reg;

    always @(posedge CLK or negedge SET_B) begin
        if (!SET_B) begin // Asynchronous active-low set
            q_reg <= 1'b1;
        end else begin
            if (SCE) begin // Scan Enable is high, load scan data
                q_reg <= SCD;
            end else begin // Scan Enable is low, load functional data
                q_reg <= D;
            end
        end
    end

    assign Q = q_reg;
    assign Q_N = ~q_reg;

endmodule
