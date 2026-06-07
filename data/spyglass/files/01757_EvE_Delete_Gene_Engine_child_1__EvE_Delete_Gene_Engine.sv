module EvE_Delete_Gene_Engine#(parameter max_deletions  = 8)(InGene, Rand, Config, Reset, clk, OutGene);

input [35:0] Rand;
input [31:0] Config;
input clk;
input Reset;
input [63:0] InGene;
output reg [63:0] OutGene;

// Wires for module interconnections
wire lw, eq, gr; // Outputs from delete_comp
wire deleted_already; // Output from delete_file (match)
wire full; // Output from delete_file
wire uhhh; // Output from valid_comp (equal to 8'hFF)

// Instance of the comparator module for deletion decision (Rand vs. Config)
comparator #(32) delete_comp(.a(Rand[35:4]),.b(Config[31:0]),.equal(eq),.lower(lw),.greater(gr));

// Signal to indicate when a node ID should be added to the deleted list.
// A node ID is added if:
// 1. Rand > Config (gr is true).
// 2. The gene is not already marked as deleted (InGene[63:56] != 8'hFF, i.e., ~uhhh).
// 3. The gene is a node (InGene[55] == 1'b0).
// The 'full' condition of the deleted nodes list is handled internally by the 'Deleted_Nodes' module.
wire add_to_deleted_nodes_list = (gr && ~uhhh && (InGene[55] == 1'b0));

// Instance of the Deleted_Nodes module to track deleted node IDs.
Deleted_Nodes #(.max_deletions(max_deletions),.DATA_WIDTH(8)) delete_file(
  .clk(clk),
  .rst(Reset),
  .conn(InGene[55]),        // Pass connection flag to Deleted_Nodes for match logic
  .node_id1(InGene[47:40]), // Node ID 1 for checking/adding
  .node_id2(InGene[39:32]), // Node ID 2 for connection checking
  .add(add_to_deleted_nodes_list), // Signal to add a node ID to the list
  .match(deleted_already),  // Output: true if node_id1/node_id2 is already deleted
  .full(full)               // Output: true if the deleted nodes list is full
);

// Instance of comparator module to check if a gene is already invalid (marked 8'hFF)
comparator #(8) valid_comp(.a(InGene[63:56]),.b(8'hFF),.equal(uhhh),.lower(),.greater());

always @(posedge clk) begin
  // Default behavior: pass the input gene directly to the output. Specific bits will be overridden.
  OutGene <= InGene;

  if (Reset) begin
    // On reset, internal counters/state of sub-modules are reset.
    // OutGene defaults to InGene as no specific reset value for it is defined.
  end else begin
    // Condition for potential deletion by comparison (Rand > Config AND gene is not already invalid)
    if (gr && ~uhhh) begin
      if (InGene[55] == 1'b1) begin  // If it's a Connection gene
        OutGene[63:56] <= 8'hFF; // Mark connection as deleted/invalid
      end else if (InGene[55] == 1'b0 && !full) begin  // If it's a Node gene AND deleted list is not full
        OutGene[63:56] <= 8'hFF; // Mark node as deleted/invalid
        // The node ID is added to 'delete_file' via 'add_to_deleted_nodes_list' signal.
      end
      // If it's a Node gene AND 'full' is true, it passes through (OutGene remains InGene).
    end else begin // If Rand <= Config OR gene is already marked deleted (uhhh is true)
      if (InGene[55] == 1'b1) begin // If it's a Connection gene
        if (deleted_already) begin // Check if this connection refers to any already deleted node
          OutGene[63:56] <= 8'hFF; // Mark connection as deleted/invalid (dangling)
        end
        // Else, the connection is valid, OutGene remains InGene (default pass-through).
      end
      // Else (if it's a Node gene), it's not subject to deletion by this path, OutGene remains InGene.
    end
  end
end

endmodule
