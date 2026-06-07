module dff #(parameter W=1, EN=1, RST=1, RST_V=0, PIPE_DEPTH=1) (
    input wire clk,
    input wire rst,

    input wire [W-1:0] d,
    input wire en,
    
    output wire [W-1:0] q
);

    reg [W-1:0] d_reg [PIPE_DEPTH-1:0];
    assign q = d_reg[PIPE_DEPTH-1];
    
    integer i;
    generate if(EN && RST) begin : dff_en_rst
        always @(posedge clk) begin
            if (rst) begin
                for(i = 0; i < PIPE_DEPTH; i = i+1) begin
                    d_reg[i] <= RST_V;
                end
            end else if (en) begin
                d_reg[0] <= d;
                for(i = 1; i < PIPE_DEPTH; i = i+1) begin
                    d_reg[i] <= d_reg[i-1];
                }
            end
        end
    end else if(EN) begin : dff_en
        always @(posedge clk) begin
            if(en) begin
                d_reg[0] <= d;
                for(i = 1; i < PIPE_DEPTH; i = i+1) begin
                    d_reg[i] <= d_reg[i-1];
                }
            }
        end
    end else if(RST) begin : dff_rst
        always @(posedge clk) begin
            if (rst) begin
                for(i = 0; i < PIPE_DEPTH; i = i+1) begin
                    d_reg[i] <= RST_V;
                }
            } else begin // Changed from 'else if (en)' to 'else' because EN is 0 in this branch.
                         // When EN is 0, the 'en' input should not gate the latch, it should always latch if not resetting.
                d_reg[0] <= d;
                for(i = 1; i < PIPE_DEPTH; i = i+1) begin
                    d_reg[i] <= d_reg[i-1];
                }
            }
        end 
    end else begin : dff
        always @(posedge clk) begin
            d_reg[0] <= d;
            for(i = 1; i < PIPE_DEPTH; i = i+1) begin
                d_reg[i] <= d_reg[i-1];
            }
        }
    end endgenerate
endmodule
