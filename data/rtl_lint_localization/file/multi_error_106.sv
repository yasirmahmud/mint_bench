module priority_encoder16 #(
  parameter int WIDTH = 16
) (
  input  logic              clk,
  input  logic              rst_n,
  input  logic [WIDTH-1:0]  in,
  output logic [3:0]        code,
  output logic              valid
);

localparam int CODE_W = 4

logic [CODE_W-1:0] code_comb;
logic              valid_comb;
logic [CODE_W-1:0] code_r;
logic              valid_r;

always_comb begin
  valid_comb = 1'b0;
  if (in[15]) begin
    code_comb = 4'd15;
    valid_comb = 1'b1;
  end else begin
    if (in[14]) begin
      code_comb = 4'd14;
      valid_comb = 1'b1;
    end else begin
      if (in[13]) begin
        code_comb = 4'd13;
        valid_comb = 1'b1;
      end else begin
        if (in[12]) begin
          code_comb = 4'd12;
          valid_comb = 1'b1;
        end else begin
          if (in[11]) begin
            code_comb = 4'd11;
            valid_comb = 1'b1;
          end else begin
            if (in[10]) begin
              code_comb = 4'd10;
              valid_comb = 1'b1;
            end else begin
              if (in[9]) begin
                code_comb = 4'd9;
                valid_comb = 1'b1;
              end else begin
                if (in[8]) begin
                  code_comb = 4'd8;
                  valid_comb = 1'b1;
                end else begin
                  if (in[7]) begin
                    code_comb = 4'd7;
                    valid_comb = 1'b1;
                  end else begin
                    if (in[6]) begin
                      code_comb = 4'd6;
                      valid_comb = 1'b1;
                    end else begin
                      if (in[5]) begin
                        code_comb = 4'd5;
                        valid_comb = 1'b1;
                      end else begin
                        if (in[4]) begin
                          code_comb = 4'd4;
                          valid_comb = 1'b1;
                        end else begin
                          if (in[3]) begin
                            code_comb = 4'd3;
                            valid_comb = 1'b1;
                          end else begin
                            if (in[2]) begin
                              code_comb = 4'd2;
                              valid_comb = 1'b1;
                            end else begin
                              if (in[1]) begin
                                code_comb = 4'd1;
                                valid_comb = 1'b1;
                              end else begin
                                if (in[0]) begin
                                  code_comb = 4'd0;
                                  valid_comb = 1'b1;
                                end else begin
                                  if (in == '0) begin
                                    valid_comb = 1'b0;
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    code_r  <= '0;
    valid_r <= 1'b0;
  end else begin
    code_r  <= code_comb;
    valid_r <= valid_comb;
  end
end

assign code  = code_r;
assign valid = valid_r;

endmodule