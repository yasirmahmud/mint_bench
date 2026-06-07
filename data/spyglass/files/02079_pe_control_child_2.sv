module pe_control(clk, ifw, fsw, psw, Mux1,Mux2, adw,adw2,ifa,complete, load, oc, ic, filter_width, start);
    input start;
    input clk;
    input load;
    input [4:0] oc;
    input [4:0] ic;
    input [4:0] filter_width;
    output reg ifw;
    output reg fsw;
    output reg psw ;
    output reg adw;
    output reg adw2;
    output reg ifa;
    output reg Mux1;
    output reg Mux2;
    output reg complete;

    reg [1:0] cnt_4;
    reg [2:0] w_add3;
    reg [2:0] w_add3_next; // Added _next variable to separate combinational and sequential parts
    reg [9:0] cnt_calc;          // Overall Completion
    reg [6:0] cnt_ifmap;         // Completion of address of ifmap counter
    wire [9:0] s3;
    wire [6:0] p4;
    reg [4:0] count;   // No initial assignment at declaration, handled by synchronous reset
    reg idle;          // No initial assignment at declaration, handled by synchronous reset
    wire rstc1,rstc2; // rstc3 is no longer needed as a separate signal

    // Combinational logic for derived values
    assign s3 = filter_width * oc * ic * 6'd4;
    assign p4 = oc * 6'd4;
    assign rstc1 = ~load & start & ~idle; // Active high synchronous reset condition for cnt_4
    assign rstc2 = ~load & start;         // Active high synchronous reset condition for cnt_calc

    // All sequential blocks now use posedge clk for synchronization

    // Counter C1: cnt_4 (Every fourth cycle, resets on rstc1)
    always @(posedge clk) begin
        if (rstc1) begin // Active high synchronous reset
            cnt_4 <= 2'h0;
        end else begin
            cnt_4 <= cnt_4 + 1;
        end
    end

    // Counter C2: cnt_calc (Counts until s3, resets on rstc2)
    always @(posedge clk) begin
        if (rstc2) begin // Active high synchronous reset
            cnt_calc <= 10'h0;
        end else begin
            cnt_calc <= cnt_calc + 1;
        end
    end

    // Counter C3: cnt_ifmap (Counts until p4-1, resets based on derived logic)
    // Original rstc3 logic was: rstc3=0 if (cnt_ifmap == (p4-1) && load == 0); else rstc3=~load;
    // This translates to an active-high reset if (load == 1) OR (cnt_ifmap == (p4-1) AND load == 0)
    // Simplified: (load == 1) || (cnt_ifmap == (p4-1))
    always @(posedge clk) begin
        if (load || (cnt_ifmap == (p4-1))) begin // Active high synchronous reset
            cnt_ifmap <= 7'h0;
        end else begin
            cnt_ifmap <= cnt_ifmap + 1;
        end
    end

    // Counter C4: w_add3 (Counts 0,1,2,3,4, then resets to 0. Resets on idle)
    // To resolve SpyGlass violation STARC05-2.11.3.1, split into combinational next-state logic and sequential update.

    // Combinational logic for w_add3_next
    always @(*) begin
        w_add3_next = w_add3; // Default assignment to avoid latches if not all paths covered
        if (idle) begin // Synchronous reset when idle is high
            w_add3_next = 3'h0;
        end else begin
            if (w_add3 == 3'b100) begin // If it reaches 4, reset it to 0 (makes it a 0-4 counter, 5 states)
                w_add3_next = 3'h0;
            end else begin
                w_add3_next = w_add3 + 1; // Increment
            end
        end
    end

    // Sequential update for w_add3
    always @(posedge clk) begin
        w_add3 <= w_add3_next; // Update on positive clock edge
    end

    // `count` and `idle` logic
    // Consolidated into one synchronous block.
    // `start` acts as a synchronous reset, `complete` sets `idle`.
    always @(posedge clk) begin
        if (start) begin // 'start' acts as a high-priority synchronous reset for a new operation
            count <= 5'b00000;
            idle <= 1'b0;
        end else begin
            if (complete) begin // If operation completes, set idle
                idle <= 1'b1;
            }
            // `count` increment logic. Only increments if not idle, and conditions met.
            // The 'load == 1'b1' condition implicitly triggers count increment, and also Mux2.
            if (!idle) {
                if((cnt_4 == 2'b10 && count < oc && !load) || (load == 1'b1)) begin
                    count <= count + 1;
                end
            }
        end
    end


    // Combinational assignments for outputs and internal control signals
    always @(*) begin
        // Default assignments for outputs to avoid latch inference
        Mux1 = 1'b0;
        complete = 1'b0;
        ifw = 1'b0; // Default for outputs to ensure no latches
        fsw = 1'b0;
        psw = 1'b0;
        adw = 1'b0;
        adw2 = 1'b0;
        ifa = 1'b0;
        Mux2 = 1'b0;

        // ifw, fsw, psw logic
        if (cnt_4 == 2'b00 && load == 1'b0) begin
            ifw = 1'b0;
            fsw = 1'b0;
            psw = 1'b1;
        }
        else if (cnt_4 == 2'b00 && load == 1'b1) begin
            ifw = 1'b1;
            fsw = 1'b1;
            psw = 1'b0;
        }
        else if (load == 1'b1) begin
            ifw = 1'b1;
            fsw = 1'b1;
            psw = 1'b0;
        }
        // Default values handle the final else branch

        // adw logic
        if (cnt_4 == 2'b11 && load == 1'b0) begin
            adw=1'b1;
        }
        // Default value handles the else branch

        // adw2 logic (w_add3 can now reach 3'b100 (4) as per new counter logic)
        if (w_add3 == 3'b100 && load == 1'b0) begin
            adw2=1'b1;
        }
        // Default value handles the else branch

        // ifa logic
        if (cnt_ifmap == (p4-1)  && load == 1'b0) begin
            ifa=1'b1;
        }
        // Default value handles the else branch

        // Mux1 and complete logic
        if (cnt_calc > s3) begin
            Mux1 = 1'b1;
            // complete remains 0 due to default
        }
        else if (cnt_calc == (s3)) begin
            complete = 1'b1;
            // Mux1 remains 0 due to default
        }
        // In all other cases, Mux1 and complete remain 0 due to defaults

        // Mux2 logic
        if((cnt_4 == 2'b10 && count < oc)|| load == 1'b1) begin
            Mux2 = 1'b1;
        }
        // Default value handles the else branch
    end // end of the always(*) block
endmodule
