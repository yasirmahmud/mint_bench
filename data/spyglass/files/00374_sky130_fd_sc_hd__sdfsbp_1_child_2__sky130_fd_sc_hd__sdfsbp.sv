module sky130_fd_sc_hd__sdfsbp (
    Q    ,
    Q_N  ,
    CLK  ,
    D    ,
    SCD  ,
    SCE  ,
    SET_B,
    VPWR ,
    VGND ,
    VPB  ,
    VNB
);

    output reg Q;
    output wire Q_N;
    input  CLK;
    input  D;
    input  SCD;
    input  SCE;
    input  SET_B;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Fix for SpyGlass W240: Power/ground inputs declared but not read.
    // These ports are for physical connectivity and not used in behavioral logic.
    // A dummy assignment satisfies the linter without affecting functional behavior.
    wire _unused_power_ports;
    assign _unused_power_ports = VPWR | VGND | VPB | VNB;

    assign Q_N = ~Q;

    always @(posedge CLK or negedge SET_B) begin
        if (!SET_B) begin // Asynchronous active-low set
            Q <= 1'b1;
        end else begin // Synchronous behavior on clock edge
            if (SCE) begin // Scan enable active
                Q <= SCD;
            end else begin // Normal mode
                Q <= D;
            end
        end
    end

endmodule
