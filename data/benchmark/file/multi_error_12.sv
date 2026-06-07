module priority_encoder16 (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         en,
    input  logic         ready_i,
    input  logic         mode_msb,
    input  logic [15:0]  din,
    output logic         valid_o,
    output logic [3:0]   code_o,
    output logic [15:0]  onehot_o
);

    logic [3:0]  idx_c;
    logic        val_c;
    logic [15:0] onehot_c;

    logic [3:0]  idx_r;
    logic        val_r;
    logic [15:0] onehot_r;

    logic        shadow_valid;
    logic        hold_last;

    logic [7:0]  accept_count;

    always_comb begin
        idx_c    = 4'd0;
        val_c    = 1'b0;
        onehot_c = 16'd0;
        if (mode_msb) begin
            if (din[15]) begin idx_c = 4'd15; val_c = 1'b1; end
            else if (din[14]) begin idx_c = 4'd14; val_c = 1'b1; end
            else if (din[13]) begin idx_c = 4'd13; val_c = 1'b1; end
            else if (din[12]) begin idx_c = 4'd12; val_c = 1'b1; end
            else if (din[11]) begin idx_c = 4'd11; val_c = 1'b1; end
            else if (din[10]) begin idx_c = 4'd10; val_c = 1'b1; end
            else if (din[9])  begin idx_c = 4'd9;  val_c = 1'b1; end
            else if (din[8])  begin idx_c = 4'd8;  val_c = 1'b1; end
            else if (din[7])  begin idx_c = 4'd7;  val_c = 1'b1; end
            else if (din[6])  begin idx_c = 4'd6;  val_c = 1'b1; end
            else if (din[5])  begin idx_c = 4'd5;  val_c = 1'b1; end
            else if (din[4])  begin idx_c = 4'd4;  val_c = 1'b1; end
            else if (din[3])  begin idx_c = 4'd3;  val_c = 1'b1; end
            else if (din[2])  begin idx_c = 4'd2;  val_c = 1'b1; end
            else if (din[1])  begin idx_c = 4'd1;  val_c = 1'b1; end
            else if (din[0])  begin idx_c = 4'd0;  val_c = 1'b1; end
        end else begin
            if (din[0])  begin idx_c = 4'd0;  val_c = 1'b1; end
            else if (din[1])  begin idx_c = 4'd1;  val_c = 1'b1; end
            else if (din[2])  begin idx_c = 4'd2;  val_c = 1'b1; end
            else if (din[3])  begin idx_c = 4'd3;  val_c = 1'b1; end
            else if (din[4])  begin idx_c = 4'd4;  val_c = 1'b1; end
            else if (din[5])  begin idx_c = 4'd5;  val_c = 1'b1; end
            else if (din[6])  begin idx_c = 4'd6;  val_c = 1'b1; end
            else if (din[7])  begin idx_c = 4'd7;  val_c = 1'b1; end
            else if (din[8])  begin idx_c = 4'd8;  val_c = 1'b1; end
            else if (din[9])  begin idx_c = 4'd9;  val_c = 1'b1; end
            else if (din[10]) begin idx_c = 4'd10; val_c = 1'b1; end
            else if (din[11]) begin idx_c = 4'd11; val_c = 1'b1; end
            else if (din[12]) begin idx_c = 4'd12; val_c = 1'b1; end
            else if (din[13]) begin idx_c = 4'd13; val_c = 1'b1; end
            else if (din[14]) begin idx_c = 4'd14; val_c = 1'b1; end
            else if (din[15]) begin idx_c = 4'd15; val_c = 1'b1; end
        end
        if (val_c) begin
            onehot_c = (16'b1 << idx_c);
        end else begin
            onehot_c = 16'd0;
        end
    end

    always_comb begin
        if (!val_c) begin
            hold_last = 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            val_r     <= 1'b0;
            idx_r     <= 4'd0;
            onehot_r  <= 16'd0;
            shadow_valid <= 1'b0;
            accept_count <= 8'd0;
        end else begin
            if (en & ready_i) begin
                if (!hold_last) begin
                    val_r     <= val_c;
                    idx_r     <= idx_c;
                    onehot_r  <= onehot_c;
                end else begin
                    val_r     <= val_r;
                    idx_r     <= idx_r;
                    onehot_r  <= onehot_r;
                end
                shadow_valid = val_r;
                if (val_c) begin
                    accept_count <= accept_count + 8'd1;
                end else begin
                    accept_count <= accept_count;
                end
            end else begin
                val_r     <= val_r;
                idx_r     <= idx_r;
                onehot_r  <= onehot_r;
                shadow_valid <= shadow_valid;
                accept_count <= accept_count;
            end
        end
    end

    assign code_o   = idx_r;
    assign valid_o  = val_r | shadow_valid;
    assign onehot_o = onehot_r;

endmodule