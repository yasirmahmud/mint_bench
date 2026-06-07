module Deleted_Nodes #(
  parameter max_deletions = 8,
  parameter DATA_WIDTH = 8
) (
  input clk,
  input rst,
  input conn, // 1 for connection, 0 for node
  input [DATA_WIDTH-1:0] node_id1,
  input [DATA_WIDTH-1:0] node_id2,
  input add,
  output reg match,
  output reg full
);

  reg [DATA_WIDTH-1:0] deleted_ids [max_deletions-1:0];
  // num_deleted needs to count up to max_deletions. Max value is max_deletions.
  // e.g., if max_deletions=8, it counts 0..8, needing $clog2(9)=4 bits. Index range [3:0].
  reg [ (max_deletions == 0 ? 0 : $clog2(max_deletions+1))-1 : 0 ] num_deleted;

  integer i;

  always @(posedge clk) begin
    if (rst) begin
      // On reset, clear the count of deleted nodes.
      // Individual IDs will be overwritten as new nodes are added.
      num_deleted <= 0;
    end else begin
      if (add && !full) begin
        // Store node_id1 when an 'add' request is asserted and the list is not full.
        // The main module's logic (node deletion) uses node_id1 (InGene[47:40]).
        deleted_ids[num_deleted] <= node_id1;
        num_deleted <= num_deleted + 1;
      end
    end
  end

  always @(*) begin
    match = 1'b0; // Default to no match
    full = (num_deleted == max_deletions); // Check if the list is full

    // Iterate through currently deleted IDs to check for a match
    for (i = 0; i < num_deleted; i = i + 1) begin
      if (conn) begin // If checking a connection, match if either node_id1 or node_id2 is deleted
        if (deleted_ids[i] == node_id1 || deleted_ids[i] == node_id2) begin
          match = 1'b1;
          break;
        end
      end else begin // If checking a node, match if node_id1 is deleted
        if (deleted_ids[i] == node_id1) begin
          match = 1'b1;
          break;
        end
      end
    end
  end

endmodule
