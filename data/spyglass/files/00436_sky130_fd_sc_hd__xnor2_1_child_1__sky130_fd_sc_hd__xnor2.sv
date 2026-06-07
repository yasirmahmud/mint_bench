module sky130_fd_sc_hd__xnor2 (
        Y,
        A,
        B,
        VPWR,
        VGND,
        VPB,
        VNB
    );
        output Y;
        input A;
        input B;
        input VPWR;
        input VGND;
        input VPB;
        input VNB;

        assign Y = ~(A ^ B); // Implements A XNOR B
    endmodule
