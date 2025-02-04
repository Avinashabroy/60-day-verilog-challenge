`timescale 1ns / 1ps

module up_down_counter(
    input clk, 
    input rst, 
    input mode,  
    output reg [3:0] count
);

always @(posedge clk ) begin
    if (!rst) 
        count <= 4'b0000;  
    else if (mode) 
        count <= count + 1;  
    else 
        count <= count - 1;  
end

endmodule

module testbench;

reg clk, rst, mode;
wire [3:0] count;

up_down_counter uut (
    .clk(clk),
    .rst(rst),
    .mode(mode),
    .count(count)
);

always #5 clk = ~clk;  

initial begin
    $monitor($time, " mode=%b, rst=%b, count=%b", mode, rst, count);

    clk = 0;    
    rst = 0;    
    mode = 1;   

    #10 rst = 1;  
    #50 mode = 0; 
    #50 $finish;  
end

endmodule

