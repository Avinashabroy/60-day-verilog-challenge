// fifo_status.v
// Generates FULL and EMPTY flags from synchronized Gray pointers

module fifo_status #(
    parameter ADDR_WIDTH = 4
)(
    // FULL: compare in write clock domain
    input  wire [ADDR_WIDTH:0] wr_ptr_gray,
    input  wire [ADDR_WIDTH:0] rd_ptr_gray_sync,   // rd pointer synced to wr_clk

    // EMPTY: compare in read clock domain
    input  wire [ADDR_WIDTH:0] rd_ptr_gray,
    input  wire [ADDR_WIDTH:0] wr_ptr_gray_sync,   // wr pointer synced to rd_clk

    output wire full,
    output wire empty
);
    // FULL: write pointer has lapped read pointer
    // Top 2 bits are INVERTED, remaining bits are EQUAL (Gray-code full condition)
    assign full = (wr_ptr_gray == {
        ~rd_ptr_gray_sync[ADDR_WIDTH:ADDR_WIDTH-1],
         rd_ptr_gray_sync[ADDR_WIDTH-2:0]
    });

    // EMPTY: both pointers are exactly equal (no data written since last read)
    assign empty = (rd_ptr_gray == wr_ptr_gray_sync);

endmodule
