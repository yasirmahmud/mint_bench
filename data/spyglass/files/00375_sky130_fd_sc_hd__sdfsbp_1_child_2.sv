module sky130_fd_sc_hd__sdfsbp_1 (
    Q    ,
    Q_N  ,
    CLK  ,
    D    ,
    SCD  ,
    SCE  ,
    SET_B
);

    output Q    ;
    output Q_N  ;
    input  CLK  ;
    input  D    ;
    input  SCD  ;
    input  SCE  ;
    input  SET_B;

    reg q_reg;

    // Implement the behavior of a scanned D flip-flop with asynchronous set
    // and complementary outputs, selecting between normal and scan data.
    always @(posedge CLK or negedge SET_B) begin
        if (!SET_B) begin // Asynchronous active-low set
            q_reg <= 1'b1;
        end else begin
            // Select between scan data (SCD) and normal data (D) based on Scan Enable (SCE)
            if (SCE) begin
                q_reg <= SCD;
            }
            else begin
                q_reg <= D;
            end
        end
    end

    // Assign outputs based on the internal register
    assign Q = q_reg;
    assign Q_N = ~q_reg;

endmodule
