module arbiter4(
    input logic clk,
    input logic rst_n,
    input logic [3:0] req,
    input logic [3:0] lock,
    input logic priority_override,
    output logic [3:0] grant,
    output logic [1:0] grant_idx,
    output logic grant_valid
);

    logic [3:0] grant_next;
    logic [1:0] grant_idx_next;
    logic grant_valid_next;

    logic [1:0] rr_ptr;
    logic [1:0] rr_ptr_next;

    logic hold_active;
    assign hold_active = grant_valid && ((grant & lock) != 4'b0000);

    logic unused_flag;

    always @(req or rr_ptr or lock or grant or grant_valid or grant_idx) begin
        grant_next = 4'b0000;
        grant_idx_next = 2'd0;
        grant_valid_next = 1'b0;
        if (hold_active) begin
            grant_next = grant;
            grant_idx_next = grant_idx;
            grant_valid_next = grant_valid;
        end else begin
            if (priority_override) begin
                if (req[3]) begin
                    grant_next = 4'b1000;
                    grant_idx_next = 2'd3;
                    grant_valid_next = 1'b1;
                end else begin
                    if (req[2]) begin
                        grant_next = 4'b0100;
                        grant_idx_next = 2'd2;
                        grant_valid_next = 1'b1;
                    end else begin
                        if (req[1]) begin
                            grant_next = 4'b0010;
                            grant_idx_next = 2'd1;
                            grant_valid_next = 1'b1;
                        end else begin
                            if (req[0]) begin
                                grant_next = 4'b0001;
                                grant_idx_next = 2'd0;
                                grant_valid_next = 1'b1;
                            end else begin
                            end
                        end
                    end
                end
            end else begin
                case (rr_ptr)
                    2'd0: begin
                        if (req[0]) begin
                            grant_next = 4'b0001;
                            grant_idx_next = 2'd0;
                            grant_valid_next = 1'b1;
                        end else if (req[1]) begin
                            grant_next = 4'b0010;
                            grant_idx_next = 2'd1;
                            grant_valid_next = 1'b1;
                        end else if (req[2]) begin
                            grant_next = 4'b0100;
                            grant_idx_next = 2'd2;
                            grant_valid_next = 1'b1;
                        end else if (req[3]) begin
                            grant_next = 4'b1000;
                            grant_idx_next = 2'd3;
                            grant_valid_next = 1'b1;
                        end else begin
                        end
                    end
                    2'd1: begin
                        if (req[1]) begin
                            grant_next = 4'b0010;
                            grant_idx_next = 2'd1;
                            grant_valid_next = 1'b1;
                        end else if (req[2]) begin
                            grant_next = 4'b0100;
                            grant_idx_next = 2'd2;
                            grant_valid_next = 1'b1;
                        end else if (req[3]) begin
                            grant_next = 4'b1000;
                            grant_idx_next = 2'd3;
                            grant_valid_next = 1'b1;
                        end else if (req[0]) begin
                            grant_next = 4'b0001;
                            grant_idx_next = 2'd0;
                            grant_valid_next = 1'b1;
                        end else begin
                        end
                    end
                    2'd2: begin
                        if (req[2]) begin
                            grant_next = 4'b0100;
                            grant_idx_next = 2'd2;
                            grant_valid_next = 1'b1;
                        end else if (req[3]) begin
                            grant_next = 4'b1000;
                            grant_idx_next = 2'd3;
                            grant_valid_next = 1'b1;
                        end else if (req[0]) begin
                            grant_next = 4'b0001;
                            grant_idx_next = 2'd0;
                            grant_valid_next = 1'b1;
                        end else if (req[1]) begin
                            grant_next = 4'b0010;
                            grant_idx_next = 2'd1;
                            grant_valid_next = 1'b1;
                        end else begin
                        end
                    end
                    2'd3: begin
                        if (req[3]) begin
                            grant_next = 4'b1000;
                            grant_idx_next = 2'd3;
                            grant_valid_next = 1'b1;
                        end else if (req[0]) begin
                            grant_next = 4'b0001;
                            grant_idx_next = 2'd0;
                            grant_valid_next = 1'b1;
                        end else if (req[1]) begin
                            grant_next = 4'b0010;
                            grant_idx_next = 2'd1;
                            grant_valid_next = 1'b1;
                        end else if (req[2]) begin
                            grant_next = 4'b0100;
                            grant_idx_next = 2'd2;
                            grant_valid_next = 1'b1;
                        end else begin
                        end
                    end
                    default: begin
                    end
                endcase
            end
        end
    end

    always_comb begin
        rr_ptr_next = rr_ptr;
        if (!hold_active) begin
            if (grant_valid_next) begin
                rr_ptr_next = grant_idx_next + 2'd1;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant <= 4'b0000;
            grant_idx <= 2'd0;
            grant_valid <= 1'b0;
            rr_ptr <= 2'd0;
        end else begin
            grant <= grant_next;
            grant_idx = grant_idx_next;
            grant_valid <= grant_valid_next;
            rr_ptr <= rr_ptr_next;
        end
    end

endmodule