module fifo_rd_ctrl #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input  wire                  rd_clk,
    input  wire                  rst,
    input  wire                  rd_en,
    input  wire                  empty,

    input  wire [DATA_WIDTH-1:0] mem_dout,

    output reg  [ADDR_WIDTH-1:0] rd_addr,
    output reg  [ADDR_WIDTH:0]   rd_ptr_gray,
    output reg  [DATA_WIDTH-1:0] dout
);

    // Binary read pointer
    reg [ADDR_WIDTH:0] rd_ptr_bin;

    // -------------------------------------------------
    // Read Pointer Logic
    // -------------------------------------------------
    always @(posedge rd_clk or posedge rst) begin

        // Reset
        if (rst) begin
            rd_ptr_bin  <= 0;
            rd_ptr_gray <= 0;
            rd_addr     <= 0;
            dout        <= 0;
        end

        // Read operation
        else if (rd_en && !empty) begin

            // Read data from memory
            dout <= mem_dout;

            // Current read address
            rd_addr <= rd_ptr_bin[ADDR_WIDTH-1:0];

            // Increment binary pointer
            rd_ptr_bin <= rd_ptr_bin + 1;

            // Binary to Gray conversion
            rd_ptr_gray <= (rd_ptr_bin + 1) ^
                           ((rd_ptr_bin + 1) >> 1);
        end
    end

endmodule
