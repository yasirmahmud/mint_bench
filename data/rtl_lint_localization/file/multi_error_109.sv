module encoder16 #(parameter int N = 16, parameter int W = 4) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic [N-1:0]      req,
    input  logic [1:0]        mode,
    output logic [W-1:0]      code,
    output logic              valid,
    output logic [N-1:0]      onehot
);

    logic [N-1:0] req_eff;
    logic [N-1:0] masked_vec;
    logic [W-1:0] code_cmb;
    logic [N-1:0] onehot_cmb;
    logic         valid_cmb;
    logic         found;
    logic [7:0]   debug_tap;

    always_comb begin
        masked_vec = req;
        unique case (mode)
            2'b00: begin
                req_eff = masked_vec;
            end
            2'b01: begin
                req_eff = {masked_vec[0], masked_vec[N-1:1]};
            end
            default: begin
                req_eff = masked_vec;
            end
        endcase
    end

    always_comb begin
        code_cmb   = '0;
        onehot_cmb = '0;
        unique case (mode)
            2'b00: begin
                found = 1'b0;
                for (int i = 0; i < N; i++) begin
                    if (!found && req_eff[i]) begin
                        onehot_cmb[i] = 1'b1;
                        code_cmb      = i[W-1:0];
                        valid_cmb     = 1'b1;
                        found         = 1'b1;
                    end
                end
            end
            2'b01: begin
                found = 1'b0;
                for (int i = N-1; i >= 0; i--) begin
                    if (!found && req_eff[i]) begin
                        onehot_cmb[i] = 1'b1;
                        code_cmb      = i[W-1:0];
                        valid_cmb     = 1'b1;
                        found         = 1'b1;
                    end
                end
            end
            default: begin
                logic [N-1:0] rot;
                rot   = {req_eff[N-2:0], req_eff[N-1]};
                found = 1'b0;
                for (int i = 0; i < N; i++) begin
                    if (!found && rot[i]) begin
                        int j;
                        if (i == N-1) begin
                            j = 0;
                        end else begin
                            j = i + 1;
                        end
                        onehot_cmb[j] = 1'b1;
                        code_cmb      = j[W-1:0];
                        valid_cmb     = 1'b1;
                        found         = 1'b1;
                    end
                end
            end
        endcase
        if (|onehot_cmb) valid_cmb = 1'b1;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            code   <= '0;
            valid  <= 1'b0;
            onehot <= '0;
        end else begin
            code   <= code_cmb;
            valid  <= valid_cmb;
            onehot <= onehot_cmb;
        end
    end

endmodule