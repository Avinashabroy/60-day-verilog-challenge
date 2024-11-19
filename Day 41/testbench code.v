`timescale 1ns / 1ps

module simple_4bit_counter_tb;

    // Testbench signals
    reg clk;             // Clock signal
    reg rst_n;           // Active-low reset
    wire [3:0] count;    // Counter output

    // Instantiate the counter module
    simple_4bit_counter uut (
        .clk(clk),
        .rst_n(rst_n),
        .count(count)
    );

    // Clock generation: 10 ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 ns
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst_n = 0;       // Apply reset
        #15;             // Hold reset for 15 ns
        rst_n = 1;       // Release reset

        // Let the counter run for a few cycles
        #160;

        // Apply reset during counting
        rst_n = 0;       // Assert reset
        #10;             // Hold reset for 10 ns
        rst_n = 1;       // Release reset

        // Let the counter
