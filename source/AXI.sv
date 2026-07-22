interface axi4_if #(
    parameter int ADDR_WIDTH = 32,
    parameter int DATA_WIDTH = 32,
    parameter int ID_WIDTH   = 4,
    parameter int USER_WIDTH = 1
)(
    input logic clk,
    input logic rst_n
);

  // =========================================================================
  // Signal Declarations
  // =========================================================================

  // Write Address Channel (AW)
  logic [ID_WIDTH-1:0]     awid;
  logic [ADDR_WIDTH-1:0]   awaddr;
  logic [7:0]              awlen;
  logic [2:0]              awsize;
  logic [1:0]              awburst;
  logic                    awlock;
  logic [3:0]              awcache;
  logic [2:0]              awprot;
  logic [3:0]              awqos;
  logic [3:0]              awregion;
  logic [USER_WIDTH-1:0]   awuser;
  logic                    awvalid;
  logic                    awready;

  // Write Data Channel (W)
  logic [DATA_WIDTH-1:0]   wdata;
  logic [(DATA_WIDTH/8)-1:0] wstrb;
  logic                    wlast;
  logic [USER_WIDTH-1:0]   wuser;
  logic                    wvalid;
  logic                    wready;

  // Write Response Channel (B)
  logic [ID_WIDTH-1:0]     bid;
  logic [1:0]              bresp;
  logic [USER_WIDTH-1:0]   buser;
  logic                    bvalid;
  logic                    bready;

  // Read Address Channel (AR)
  logic [ID_WIDTH-1:0]     arid;
  logic [ADDR_WIDTH-1:0]   araddr;
  logic [7:0]              arlen;
  logic [2:0]              arsize;
  logic [1:0]              arburst;
  logic                    arlock;
  logic [3:0]              arcache;
  logic [2:0]              arprot;
  logic [3:0]              arqos;
  logic [3:0]              arregion;
  logic [USER_WIDTH-1:0]   aruser;
  logic                    arvalid;
  logic                    arready;

  // Read Data Channel (R)
  logic [ID_WIDTH-1:0]     rid;
  logic [DATA_WIDTH-1:0]   rdata;
  logic [1:0]              rresp;
  logic                    rlast;
  logic [USER_WIDTH-1:0]   ruser;
  logic                    rvalid;
  logic                    rready;

  // =========================================================================
  // Modports
  // =========================================================================

  // Manager (Master) Modport
  modport manager (
    // Global
    input  clk, rst_n,
    
    // Write Address
    output awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awqos, awregion, awuser, awvalid,
    input  awready,
    
    // Write Data
    output wdata, wstrb, wlast, wuser, wvalid,
    input  wready,
    
    // Write Response
    input  bid, bresp, buser, bvalid,
    output bready,
    
    // Read Address
    output arid, araddr, arlen, arsize, arburst, arlock, arcache, arprot, arqos, arregion, aruser, arvalid,
    input  arready,
    
    // Read Data
    input  rid, rdata, rresp, rlast, ruser, rvalid,
    output rready
  );

  // Subordinate (Slave) Modport
  modport subordinate (
    // Global
    input  clk, rst_n,
    
    // Write Address
    input  awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awqos, awregion, awuser, awvalid,
    output awready,
    
    // Write Data
    input  wdata, wstrb, wlast, wuser, wvalid,
    output wready,
    
    // Write Response
    output bid, bresp, buser, bvalid,
    input  bready,
    
    // Read Address
    input  arid, araddr, arlen, arsize, arburst, arlock, arcache, arprot, arqos, arregion, aruser, arvalid,
    output arready,
    
    // Read Data
    output rid, rdata, rresp, rlast, ruser, rready, rvalid
  );

endinterface : axi4_if