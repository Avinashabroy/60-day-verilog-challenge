`timescale 1ns/1ps

module fifo_tb;

parameter DEPTH = 16;
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 4;

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [DATA_WIDTH-1:0] wr_data;

wire full;
wire empty;
wire [DATA_WIDTH-1:0] rd_data;

// DUT
fifo_top #(DEPTH, DATA_WIDTH, ADDR_WIDTH) uut (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .wr_data(wr_data),
    .rd_data(rd_data),
    .full(full),
    .empty(empty)
);

// Clock generation
always #5 clk = ~clk;  // 10ns clock

integer i;

initial begin
    // Initialize
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    wr_data = 0;

    // Reset
    #10;
    rst = 0;

    // Start writing after 10ns
    #10;
    wr_en = 1;

    // Write 16 values
    for(i = 1; i <= 15; i = i + 1) begin
        @(posedge clk);
        wr_data = i;
    end

    wr_en = 0;

    // Check FULL
    #10;
    if(full)
        $display("FIFO is FULL at time %t", $time);
    else
        $display("FIFO is NOT FULL at time %t", $time);

    // Start reading
    rd_en = 1;

    for(i = 1; i <= 16; i = i + 1) begin
        @(posedge clk);
    end

    rd_en = 0;

    // Check EMPTY
    #10;
    if(empty)
        $display("FIFO is EMPTY at time %t", $time);
    else
        $display("FIFO is NOT EMPTY at time %t", $time);

    #20;
    $finish;
end

endmodule
