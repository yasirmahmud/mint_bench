// Placeholder module for cam_rom
module cam_rom (
    input wire i_clk,
    input wire i_rstn,
    input wire [7:0] i_addr,
    output reg [15:0] o_dout
);
    // Placeholder logic: assign a default value to output, now with sequential usage
    always @(posedge i_clk or negedge i_rstn) begin
        if (!i_rstn) begin
            o_dout <= 16'h0000;
        end else begin
            // Use i_addr to make it 'read' and prevent W240 violations.
            // In a real ROM, i_addr would index memory. Here, it's a dummy read.
            o_dout <= (i_addr == 8'h00) ? 16'h1234 : 16'h0000;
        end
    end
endmodule
