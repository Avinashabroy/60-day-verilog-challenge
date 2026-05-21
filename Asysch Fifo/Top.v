module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input  wire                  wr_clk,
    input  wire                  rd_clk,
    input  wire                  rst,
    input  wire                  wr_en,
    input  wire                  rd_en,
    input  wire [DATA_WIDTH-1:0] din,
    output wire [DATA_WIDTH-1:0] dout,
    output wire                  full,
    output wire                  empty
);

    // Internal wires
    wire [ADDR_WIDTH-1:0] wr_addr, rd_addr;
    wire [ADDR_WIDTH:0]   wr_ptr_gray, rd_ptr_gray;
    wire [ADDR_WIDTH:0]   wr_ptr_gray_sync, rd_ptr_gray_sync;
    wire [DATA_WIDTH-1:0] mem_dout;

    // 1. Dual-port memory
   fifo_mem #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) u_mem (

    .wr_clk (wr_clk),
    .rd_clk (rd_clk),

    .wr_en  (wr_en),

    .wr_addr(wr_addr),
    .din    (din),

    .rd_addr(rd_addr),
    .dout   (mem_dout)

);

    // 2. Write controller
    fifo_wr_ctrl #(ADDR_WIDTH) u_wr_ctrl (
        .wr_clk     (wr_clk),
        .rst        (rst),
        .wr_en      (wr_en),
        .full       (full),
        .wr_addr    (wr_addr),
        .wr_ptr_gray(wr_ptr_gray)
    );

    // 3. Read controller
    fifo_rd_ctrl #(DATA_WIDTH, ADDR_WIDTH) u_rd_ctrl (
        .rd_clk     (rd_clk),
        .rst        (rst),
        .rd_en      (rd_en),
        .empty      (empty),
        .mem_dout   (mem_dout),
        .rd_addr    (rd_addr),
        .rd_ptr_gray(rd_ptr_gray),
        .dout       (dout)
    );

    // 4a. Sync read pointer | write clock domain
    sync_2ff #(ADDR_WIDTH+1) u_sync_rd2wr (
        .clk (wr_clk),
        .rst (rst),
        .d   (rd_ptr_gray),
        .q   (rd_ptr_gray_sync)
    );

    // 4b. Sync write pointer | read clock domain
    sync_2ff #(ADDR_WIDTH+1) u_sync_wr2rd (
        .clk (rd_clk),
        .rst (rst),
        .d   (wr_ptr_gray),
        .q   (wr_ptr_gray_sync)
    );

    // 5. Full/Empty flags
    fifo_status #(ADDR_WIDTH) u_status (
        .wr_ptr_gray      (wr_ptr_gray),
        .rd_ptr_gray_sync (rd_ptr_gray_sync),
        .rd_ptr_gray      (rd_ptr_gray),
        .wr_ptr_gray_sync (wr_ptr_gray_sync),
        .full             (full),
        .empty            (empty)
    );
Endmodule

