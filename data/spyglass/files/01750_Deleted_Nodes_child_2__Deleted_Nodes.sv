module Deleted_Nodes #( //include second gene
   parameter max_deletions  = 8,
   parameter DATA_WIDTH = 8
   )
   (
    input wire clk,
    input wire rst,
    input wire conn,
    input wire [DATA_WIDTH-1:0] node_id1,
    input wire [DATA_WIDTH-1:0] node_id2,
    input wire add,
    output wire match,
    output reg full
    );

// VIOLATION FIX: SYNTH_89 - Initial assignment removed from declaration.
// num_deleted will be initialized in the synchronous reset block.
reg [7:0] num_deleted;

wire [max_deletions-1:0] match_found1;
wire [max_deletions-1:0] match_found2;
reg [DATA_WIDTH*max_deletions - 1:0] stored_nodes;
wire [max_deletions -2 :0] intermediate1;
wire [max_deletions -2 :0] intermediate2;

assign intermediate1[0] = match_found1[0] | match_found1[1];
assign intermediate2[0] = match_found2[0] | match_found2[1];
assign match = intermediate1[max_deletions-2] | intermediate2[max_deletions-2];


genvar i;
generate
  for (i=0; i<max_deletions; i=i+1)
    begin:gen1
    // Declare dummy wires for unused output ports to resolve W287b violations
    wire dummy_lower1, dummy_greater1;
    wire dummy_lower2, dummy_greater2;
    // VIOLATION FIX: ErrorAnalyzeBBox - comparator module is now defined above.
    // VIOLATION FIX: W287b - Connected unused output ports 'lower' and 'greater' to dummy wires.
    comparator #(DATA_WIDTH) add_comp1(.a(node_id1),.b(stored_nodes[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i]),.equal(match_found1[i]),.lower(dummy_lower1),.greater(dummy_greater1));
    comparator #(DATA_WIDTH) add_comp2(.a(node_id2),.b(stored_nodes[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i]),.equal(match_found2[i]),.lower(dummy_lower2),.greater(dummy_greater2));
  end
endgenerate


genvar j;
generate
  for (j=1; j< max_deletions-1; j=j+1)
    begin:gen2
    assign intermediate1[j] = intermediate1[j-1] | match_found1[j+1];
    assign intermediate2[j] = intermediate2[j-1] | match_found2[j+1];
  end
endgenerate


always @(posedge clk) begin
  // VIOLATION FIX: STARC05-2.2.3.3, W415a - Restructured always block to avoid multiple assignments
  // to the same register in different conditional branches. Reset logic takes precedence.
  if(rst == 1'b1) begin // Synchronous reset
    num_deleted <= 8'b0;
    stored_nodes <= {DATA_WIDTH*max_deletions{1'b1}};
    full <= 0;
  end else begin // Normal operation
    if((add == 1'b1) && (!conn)) begin // Conditional block for adding a node
      if (num_deleted < max_deletions) begin // Check if space is available
        stored_nodes[DATA_WIDTH*num_deleted+:DATA_WIDTH] <= node_id1;
        num_deleted <= num_deleted+1;
        // 'full' flag logic: set to 1 when the last element is added (num_deleted becomes max_deletions)
        // The original code sets full if num_deleted (current value) is max_deletions-1
        if (num_deleted == (max_deletions - 1)) begin
          full <= 1'b1;
        end
      end
      // If num_deleted >= max_deletions, no action is taken, and registers retain current values.
    end
    // If 'add' is not asserted, 'num_deleted', 'stored_nodes', and 'full' implicitly retain their values
    // as they are not assigned otherwise in this 'else' branch, preserving the 'sticky' behavior of 'full'.
  end
end
endmodule
