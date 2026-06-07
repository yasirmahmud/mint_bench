module pcie_7x_0_gt_common #(

parameter PCIE_SIM_MODE    = "FALSE",   // PCIe sim mode
parameter PCIE_GT_DEVICE   = "GTX",     // PCIe GT device
parameter PCIE_USE_MODE    = "2.1",     // PCIe use mode
parameter PCIE_PLL_SEL     = "CPLL",    // PCIe PLL select for Gen1/Gen2 only
parameter PCIE_REFCLK_FREQ = 0          // PCIe reference clock frequency
)

(
input                   CPLLPDREFCLK,
input               	PIPE_CLK,
input               	QPLL_QPLLPD,
input               	QPLL_QPLLRESET,
input               	QPLL_DRP_CLK,
input               	QPLL_DRP_RST_N,
input               	QPLL_DRP_OVRD,
input               	QPLL_DRP_GEN3,
input               	QPLL_DRP_START,
output      [5:0]  	QPLL_DRP_CRSCODE,
output      [8:0]  	QPLL_DRP_FSM,
output                  QPLL_DRP_DONE,
output                  QPLL_DRP_RESET,
output                  QPLL_QPLLLOCK,
output                  QPLL_QPLLOUTCLK,
output                  QPLL_QPLLOUTREFCLK
);

    //---------- QPLL DRP Module Output --------------------

wire        [7:0]  qpll_drp_addr;
wire               qpll_drp_en;
wire        [15:0] qpll_drp_di;
wire               qpll_drp_we;

   //---------- QPLL Wrapper Output -----------------------

wire        [15:0] qpll_drp_do;
wire               qpll_drp_rdy;

   //---------- QPLL Resets -----------------------


        //---------- QPLL DRP Module ---------------------------------------

pcie_7x_0_qpll_drp #
        (

	        .PCIE_GT_DEVICE                 (PCIE_GT_DEVICE),               // PCIe GT device
	        .PCIE_USE_MODE                  (PCIE_USE_MODE),                // PCIe use mode
	        .PCIE_PLL_SEL                   (PCIE_PLL_SEL),                 // PCIe PLL select for Gen1/Gen2 only
	        .PCIE_REFCLK_FREQ               (PCIE_REFCLK_FREQ)              // PCIe reference clock frequency

        )
        qpll_drp_i
        (

        //---------- Input -------------------------
	    .DRP_CLK                        (QPLL_DRP_CLK),
            .DRP_RST_N                      (!QPLL_DRP_RST_N),
            .DRP_OVRD                       (QPLL_DRP_OVRD),
            .DRP_GEN3                       (&QPLL_DRP_GEN3),
            .DRP_QPLLLOCK                   (QPLL_QPLLLOCK),
            .DRP_START                      (QPLL_DRP_START),
            .DRP_DO                         (qpll_drp_do),
            .DRP_RDY                        (qpll_drp_rdy),
																													     
        //----------           Output ------------------------
            .DRP_ADDR                       (qpll_drp_addr),
            .DRP_EN                         (qpll_drp_en),
            .DRP_DI                         (qpll_drp_di),
            .DRP_WE                         (qpll_drp_we),
            .DRP_DONE                       (QPLL_DRP_DONE),
            .DRP_QPLLRESET                  (QPLL_DRP_RESET),
            .DRP_CRSCODE                    (QPLL_DRP_CRSCODE),
            .DRP_FSM                        (QPLL_DRP_FSM)
        );


        //---------- QPLL Wrapper ------------------------------------------
pcie_7x_0_qpll_wrapper #
        (
	        .PCIE_SIM_MODE                  (PCIE_SIM_MODE),                // PCIe sim mode
	        .PCIE_GT_DEVICE                 (PCIE_GT_DEVICE),               // PCIe GT device
	        .PCIE_USE_MODE                  (PCIE_USE_MODE),                // PCIe use mode
	        .PCIE_PLL_SEL                   (PCIE_PLL_SEL),                 // PCIe PLL select for Gen1/Gen2 only
	        .PCIE_REFCLK_FREQ               (PCIE_REFCLK_FREQ)              // PCIe reference clock frequency
        )
        qpll_wrapper_i
        (
        //---------- QPLL Clock Ports --------------
            .QPLL_CPLLPDREFCLK              (CPLLPDREFCLK),
            .QPLL_GTGREFCLK                 (PIPE_CLK),
            .QPLL_QPLLLOCKDETCLK            (1'd0),
            .QPLL_QPLLOUTCLK                (QPLL_QPLLOUTCLK),
            .QPLL_QPLLOUTREFCLK             (QPLL_QPLLOUTREFCLK),
            .QPLL_QPLLLOCK                  (QPLL_QPLLLOCK),
        //---------- QPLL Reset Ports --------------
            .QPLL_QPLLPD                    (QPLL_QPLLPD),
            .QPLL_QPLLRESET                 (QPLL_QPLLRESET),
        //---------- QPLL DRP Ports ----------------
            .QPLL_DRPCLK                    (QPLL_DRP_CLK),
            .QPLL_DRPADDR                   (qpll_drp_addr),
            .QPLL_DRPEN                     (qpll_drp_en),
            .QPLL_DRPDI                     (qpll_drp_di),
            .QPLL_DRPWE                     (qpll_drp_we),
            .QPLL_DRPDO                     (qpll_drp_do),
            .QPLL_DRPRDY                    (qpll_drp_rdy)			
        );
  
endmodule
