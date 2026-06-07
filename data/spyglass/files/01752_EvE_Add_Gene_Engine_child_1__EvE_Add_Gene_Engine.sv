module EvE_Add_Gene_Engine(InGene, Rand, Config, Reset, clk, OutGene1, OutGene2, OutGene3 );

input [35:0] Rand;
input [31:0] Config;
input clk;
input Reset;
input [63:0] InGene;
output reg [63:0] OutGene1, OutGene2, OutGene3;
//reg [8 * max_deletions -1:0] deletedNodeIDs;
reg [7:0]prevID;
wire [7:0]maxNodeID;
reg cntEn;
reg wr1, wr2, wr3;
wire lwr, equ, grt;
reg rdWire;

counter #(.DATA_WIDTH(8), .COUNT_FROM(0)) maxNodeIDReg (.clk(clk), .en(cntEn), .rst(Reset), .out(maxNodeID));
comparator #(32) add_comp(.a(Rand[34:3]),.b(Config[31:0]),.equal(equ),.lower(lwr),.greater(grt));
tri_ported_fifo out_Fifo (
	.clk(clk) ,
	.rst(Reset)      ,
	.data_in1(OutGene1)  ,
  .data_in2(OutGene2)  ,
  .data_in3(OutGene3)  ,
	.read(rdWire)    ,
//	.en(1),
	.write1(wr1)    ,
  .write2(wr2)    ,
  .write3(wr3)    ,
	.data_out() ,
	.fifo_empty()    ,
	.fifo_full()
	);

always @(posedge clk) begin
    // Declare combinational next-state variables for all sequential outputs
    reg [7:0] next_prevID;
    reg next_cntEn;
    reg next_wr1, next_wr2, next_wr3;
    reg next_rdWire;
    reg [63:0] next_OutGene1, next_OutGene2, next_OutGene3;

    if (Reset) begin
        next_prevID = 8'h05;
        next_rdWire = 1'b0;
        next_cntEn = 1'b0;
        next_wr1 = 1'b0;
        next_wr2 = 1'b0;
        next_wr3 = 1'b0;
        next_OutGene1 = 64'hFFFFFFFFFFFFFFFF; // Explicit reset value
        next_OutGene2 = 64'hFFFFFFFFFFFFFFFF;
        next_OutGene3 = 64'hFFFFFFFFFFFFFFFF;
    end else begin
        // Default to hold current value for registers if not explicitly updated in conditional blocks
        next_prevID = prevID;
        next_cntEn = cntEn;
        next_wr1 = wr1;
        next_wr2 = wr2;
        next_wr3 = wr3;
        next_rdWire = rdWire;
        next_OutGene1 = OutGene1; // Default to hold if not updated
        next_OutGene2 = OutGene2;
        next_OutGene3 = OutGene3;

        if (InGene[55] == 1'b1 && InGene[63:56] != 8'b11111111) begin  // Connections Streaming
            next_prevID = InGene[47:40];

            if (grt == 1'b1) begin
                // Add a Node -> split this connection in two
                next_OutGene2[63:56] = InGene[63:56];
                next_OutGene2[55] = 1'b0; //
                next_OutGene2[54:53] = InGene[54:53];
                next_OutGene2[47:40] = maxNodeID; //
                next_OutGene2[31:0] = 32'hC0C0C0C0;
                next_cntEn = 1'b1;
                // Add Connection from Src to New Node
                next_OutGene1[63:56] = InGene[63:56];
                next_OutGene1[55] = 1'b1; //
                next_OutGene1[54:53] = InGene[54:53];
                next_OutGene1[47:40] = InGene[47:40]; //src
                next_OutGene1[39:32] = maxNodeID; //dest
                next_OutGene1[31:0] = InGene[31:0];
                // Add Connection from New Node to Dest
                next_OutGene3[63:56] = InGene[63:56];
                next_OutGene3[55] = 1'b1; //
                next_OutGene3[54:53] = InGene[54:53];
                next_OutGene3[47:40] = maxNodeID; //src
                next_OutGene3[39:32] = InGene[39:32];
                next_OutGene3[31:0] = 32'hC0C0C0C0;
                //
                if (prevID != InGene[47:40]) begin
                    next_wr1 = 1'b0;
                    next_wr2 = 1'b0;
                    next_wr3 = 1'b1;
                end else begin
                    next_wr1 = 1'b0;
                    next_wr2 = 1'b0;
                    next_wr3 = 1'b0;
                end
            end else begin
                next_OutGene1 = InGene;
                next_OutGene2 = 64'hFFFFFFFFFFFFFFFF;
                next_OutGene3 = 64'hFFFFFFFFFFFFFFFF;
                next_cntEn = 1'b0;
                if (prevID != InGene[47:40]) begin
                    next_wr1 = 1'b1;
                    next_wr2 = 1'b0;
                    next_wr3 = 1'b0;
                end else begin
                    next_wr1 = 1'b0;
                    next_wr2 = 1'b0;
                    next_wr3 = 1'b0;
                }
            }

        end else if (InGene[55] == 1'b0 && InGene[63:56] != 8'b11111111) begin  // NODES Streaming
            next_prevID = InGene[47:40];
            next_OutGene1 = InGene;
            if (InGene[47:40] >= maxNodeID) begin
                next_cntEn = 1'b1;
            end else begin
                next_cntEn = 1'b0;
            end
            if (grt == 1'b1) begin
                // Add a Connection
                next_OutGene2[63:56] = InGene[63:56];
                next_OutGene2[55:53] = 3'b100;
                next_OutGene2[47:40] = InGene[47:40];
                next_OutGene2[39:32] = prevID; // Original behavior preserved: uses 'prevID' from previous cycle
                next_OutGene2[31:0] = 32'hC0C0C0C0;
                if (prevID != InGene[47:40]) begin
                    next_wr1 = 1'b0;
                    next_wr2 = 1'b1;
                    next_wr3 = 1'b0;
                end else begin
                    next_wr1 = 1'b0;
                    next_wr2 = 1'b0;
                    next_wr3 = 1'b0;
                end
            end else begin
                next_OutGene2 = 64'hFFFFFFFFFFFFFFFF;
                if (prevID != InGene[47:40]) begin
                    next_wr1 = 1'b1;
                    next_wr2 = 1'b0;
                    next_wr3 = 1'b0;
                end else begin
                    next_wr1 = 1'b0;
                    next_wr2 = 1'b0;
                    next_wr3 = 1'b0;
                }
            end
            next_OutGene3 = 64'hFFFFFFFFFFFFFFFF;
        end else if (InGene[55] == 1'b0) begin // This handles nodes with InGene[63:56] == 8'b11111111 or other unhandled node cases
            // prevID holds its value (due to next_prevID = prevID default)
            if (InGene[47:40] >= maxNodeID) begin
                next_cntEn = 1'b1;
            end else begin
                next_cntEn = 1'b0;
            end
            next_wr1 = 1'b0;
            next_wr2 = 1'b0;
            next_wr3 = 1'b0;
            // OutGene1,2,3 not assigned in original code for this branch; they will hold their value from defaults (next_OutGeneX = OutGeneX).
        end else begin // This is the catch-all for any other unhandled InGene conditions
            next_cntEn = 1'b0;
            next_OutGene1 = 64'hFFFFFFFFFFFFFFFF;
            next_OutGene2 = 64'hFFFFFFFFFFFFFFFF;
            next_OutGene3 = 64'hFFFFFFFFFFFFFFFF;
            next_wr1 = 1'b0;
            next_wr2 = 1'b0;
            next_wr3 = 1'b0;
        end
    end

    // Apply all next-state values to registers using non-blocking assignments
    prevID <= next_prevID;
    cntEn <= next_cntEn;
    wr1 <= next_wr1;
    wr2 <= next_wr2;
    wr3 <= next_wr3;
    rdWire <= next_rdWire;
    OutGene1 <= next_OutGene1;
    OutGene2 <= next_OutGene2;
    OutGene3 <= next_OutGene3;
end

endmodule
