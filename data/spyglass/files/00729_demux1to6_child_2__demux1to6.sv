// Main demultiplexer module (1-to-6)
module demux1to6 #(parameter WIDTH = 1) (
    input [WIDTH-1:0] din,
    input [2:0] sel,
    output [WIDTH-1:0] out1,
    output [WIDTH-1:0] out2,
    output [WIDTH-1:0] out3,
    output [WIDTH-1:0] out4,
    output [WIDTH-1:0] out5,
    output [WIDTH-1:0] out6
);

// Internal wires for cascading demuxes
// Wires for outputs of the first stage demultiplexer (controlled by sel[2])
wire [WIDTH-1:0] s1_out_0, s1_out_1;

// Wires for outputs of the second stage demultiplexers (controlled by sel[1])
wire [WIDTH-1:0] s2_out_00, s2_out_01, s2_out_10, s2_out_11;

// Stage 1: Divides input based on sel[2] (MSB)
// s1_out_0 corresponds to sel[2]=0 (paths for 000-011)
// s1_out_1 corresponds to sel[2]=1 (paths for 100-111)
demux1to2 #(WIDTH) u_demux_s1 (
    .din  (din),
    .sel  (sel[2]),
    .out0 (s1_out_0),
    .out1 (s1_out_1)
);

// Stage 2: Divides paths further based on sel[1]
// Handles the s1_out_0 path (sel[2]=0)
demux1to2 #(WIDTH) u_demux_s2_0 (
    .din  (s1_out_0),
    .sel  (sel[1]),
    .out0 (s2_out_00), // sel[2:1]=00 (paths for 000-001)
    .out1 (s2_out_01)  // sel[2:1]=01 (paths for 010-011)
);

// Handles the s1_out_1 path (sel[2]=1)
demux1to2 #(WIDTH) u_demux_s2_1 (
    .din  (s1_out_1),
    .sel  (sel[1]),
    .out0 (s2_out_10), // sel[2:1]=10 (paths for 100-101)
    .out1 (s2_out_11)  // sel[2:1]=11 (paths for 110-111 - unmapped outputs)
);

// Stage 3: Final division and mapping to outputs based on sel[0]
// Maps for sel[2:1]=00
demux1to2 #(WIDTH) u_demux_s3_0 (
    .din  (s2_out_00),
    .sel  (sel[0]),
    .out0 (out1), // sel[2:0]=000
    .out1 (out2)  // sel[2:0]=001
);

// Maps for sel[2:1]=01
demux1to2 #(WIDTH) u_demux_s3_1 (
    .din  (s2_out_01),
    .sel  (sel[0]),
    .out0 (out3), // sel[2:0]=010
    .out1 (out4)  // sel[2:0]=011
);

// Maps for sel[2:1]=10
demux1to2 #(WIDTH) u_demux_s3_2 (
    .din  (s2_out_10),
    .sel  (sel[0]),
    .out0 (out5), // sel[2:0]=100
    .out1 (out6)  // sel[2:0]=101
);

// Handle unmapped select values (110, 111)
// The outputs of this demux are not connected to external ports.
// Since s2_out_11 would be '0' if not selected, these internal wires will naturally be '0'.
// Explicit instantiation makes the tree complete, though these outputs are not user-facing.
// To resolve W528, the unused outputs are connected to null ports.
demux1to2 #(WIDTH) u_demux_s3_3 (
    .din  (s2_out_11),
    .sel  (sel[0]),
    .out0 (),
    .out1 ()
);

endmodule
