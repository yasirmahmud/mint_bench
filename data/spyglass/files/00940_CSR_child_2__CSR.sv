module CSR(
    input clk,
    input rst,
    input [31:0] pc,
    input [11:0] csr_address,
    input [31:0] csr_write_data,
    input csr_write,
    input interrupt,
    input instruction,
    output [31:0] csr_read_data,
    output reg comp,
    output reg [3:0] mie,
    output reg [31:0] mepc
);
    
    // Local parameters for CSR register indices for better readability
    localparam CSR_MCYCLE    = 0;
    localparam CSR_MTIME     = 1;
    localparam CSR_MTIMCMP   = 2;
    localparam CSR_MINSTRET  = 3;
    localparam CSR_MEPC      = 4;
    localparam CSR_MIE       = 5;
    localparam CSR_MIP       = 6;

    reg [2:0] address_mapped;
    wire Dclk_internal;    // Dclk output from ClkCounter (unused in CSR module)
    wire counter_pulse;    // 'counter' pulse from ClkCounter

    reg [31:0] csr_rf[0:6]; // Register file declared with standard indexing [0:6]

    // Instantiate ClkCounter module
    ClkCounter c(.clk_small(clk), .rst(rst), .counter(counter_pulse), .Dclk(Dclk_internal));

    // Combinational logic for address mapping and output registers comp, mie, mepc
    always@(*)
    begin
        // Map csr_address to internal register file index
        case(csr_address)
            12'hB00: address_mapped = CSR_MCYCLE;    // mcycle
            12'hB01: address_mapped = CSR_MTIME;     // mtime
            12'hB03: address_mapped = CSR_MTIMCMP;   // mtimecmp
            12'hB02: address_mapped = CSR_MINSTRET;  // minstret
            12'h341: address_mapped = CSR_MEPC;      // mepc
            12'h304: address_mapped = CSR_MIE;       // mie
            12'h305: address_mapped = CSR_MIP;       // mip
            default: address_mapped = CSR_MCYCLE;    // Default to a valid address to prevent X propagation
        endcase

        // 'comp' output is purely combinational, comparing mtime and mtimecmp
        if (csr_rf[CSR_MTIME] >= csr_rf[CSR_MTIMCMP])
            comp = 1;
        else
            comp = 0;

        mie = csr_rf[CSR_MIE][3:0]; // 'mie' output combinatorially reflects csr_rf[CSR_MIE]
        mepc = csr_rf[CSR_MEPC];    // 'mepc' output combinatorially reflects csr_rf[CSR_MEPC]
    end

    // Combinational assignment for csr_read_data output
    assign csr_read_data =  csr_rf[address_mapped];

    integer i;
    // Synchronous block for all CSR register updates with asynchronous reset
    always @ (posedge clk or posedge rst) 
    begin
        if (rst) begin
            // Reset all CSR registers except mtimecmp and mie to 0
            for (i=0; i<=6; i=i+1) begin
                if ((i != CSR_MTIMCMP) && (i != CSR_MIE)) begin
                    csr_rf[i] <= 32'b0;
                end
            end
            // Set initial hardcoded values for mtimecmp and mie
            csr_rf[CSR_MTIMCMP] <= 32'd2000; // mtimecmp hardcoded initial value
            csr_rf[CSR_MIE] <= 32'b01111;    // mie hardcoded initial value
        end else begin
            // Use a temporary array to calculate the next state of CSR registers
            // This prevents multiple assignments to the same register in a single cycle.
            reg [31:0] next_csr_rf [0:6];

            // By default, registers retain their current value (no change)
            for (i=0; i<=6; i=i+1) begin
                next_csr_rf[i] = csr_rf[i];
            end

            // Apply increments and event-triggered updates based on current values
            next_csr_rf[CSR_MCYCLE] = csr_rf[CSR_MCYCLE] + 1; // mcycle updates every clock cycle
            
            if (instruction) begin // minstret increments if instruction is high
                next_csr_rf[CSR_MINSTRET] = csr_rf[CSR_MINSTRET] + 1;
            end
            
            if (counter_pulse) begin // mtime increments on the 'counter_pulse'
                next_csr_rf[CSR_MTIME] = csr_rf[CSR_MTIME] + 1;
            end

            // mepc captures pc on 'interrupt' (assuming 'interrupt' is a synchronous pulse to clk)
            if (interrupt) begin 
                next_csr_rf[CSR_MEPC] = pc;
            end

            // Apply CSR write: if csr_write is active, it overrides any increments/updates
            // for the specific address, ensuring write priority.
            if (csr_write) begin
                next_csr_rf[address_mapped] = csr_write_data;
            end

            // Update all CSR file registers with their determined next values
            for (i=0; i<=6; i=i+1) begin
                csr_rf[i] <= next_csr_rf[i];
            end
        end
    end

endmodule
