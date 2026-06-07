`default_nettype none

module mint_latch_bank9 (
    input  logic [3:0]  ctrl,
    input  logic [31:0] data_in,
    output logic [8:0]  latch_vec
);
    logic lb0;
    logic lb1;
    logic lb2;
    logic lb3;
    logic lb4;
    logic lb5;
    logic lb6;
    logic lb7;
    logic lb8;

    assign latch_vec = {lb8, lb7, lb6, lb5, lb4, lb3, lb2, lb1, lb0};

    // Intentionally incomplete assignments to infer latches (for lint violations).
    always_comb begin
        if (ctrl[0]) begin
            lb0 = data_in[0];
        end
    end

    always_comb begin
        if (ctrl[1]) begin
            lb1 = data_in[1];
        end
    end

    always_comb begin
        if (ctrl[2]) begin
            lb2 = data_in[2];
        end
    end

    always_comb begin
        if (ctrl[3]) begin
            lb3 = data_in[3];
        end
    end

    always_comb begin
        if (ctrl[0] && ctrl[1]) begin
            lb4 = data_in[4] ^ data_in[12];
        end
    end

    always_comb begin
        if (ctrl[1] && ctrl[2]) begin
            lb5 = data_in[5] ^ data_in[13];
        end
    end

    always_comb begin
        if (ctrl[2] && ctrl[3]) begin
            lb6 = data_in[6] ^ data_in[14];
        end
    end

    always_comb begin
        if (ctrl[3] && ctrl[0]) begin
            lb7 = data_in[7] ^ data_in[15];
        end
    end

    always_comb begin
        if (&ctrl) begin
            lb8 = data_in[8] ^ data_in[16];
        end
    end
endmodule

`default_nettype wire

