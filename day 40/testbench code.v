`timescale 1ns / 1ps

module universal_register_tb;
  // Testbench signals
  reg [3:0] data_input;
  reg [1:0] sel;
  reg clock;
  reg left_in;
  reg right_in;
  wire [3:0] data_output;

  // Instantiate the universal register
  universal_register uut (
    .data_input(data_input),
    .sel(sel),
    .clock(clock),
    .left_in(left_in),
    .right_in(right_in),
    .data_output(data_output)
  );

  // Clock generation
  initial begin
    clock = 0;
    forever #5 clock = ~clock; // Toggle clock every 5 ns
  end

  // Initialize the dumpfile and dumpvars for waveform generation
  initial begin
    $dumpfile("dump.vcd");  // Specifies the VCD output file
    $dumpvars(0, universal_register_tb); // Dumps all variables in the testbench
  end

  // Test sequence
  initial begin
    // Initial values
    data_input = 4'b0000;
    sel = 2'b00;
    left_in = 0;
    right_in = 0;

    // Monitor outputs
    $monitor("Time: %0t | sel: %b | data_input: %b | left_in: %b | right_in: %b | data_output: %b", 
              $time, sel, data_input, left_in, right_in, data_output);

    // Apply test cases
    #10; // Wait for 10 ns

    // Test case 1: Load new data (PIPO operation)
    sel = 2'b11;
    data_input = 4'b1010;
    #10; // Wait for one clock cycle
    // Expect data_output = 1010

    // Test case 2: Shift right with right_in = 1
    sel = 2'b01;
    right_in = 1;
    #10;
    // Expect data_output to shift right and become 1101

    // Test case 3: Shift left with left_in = 0
    sel = 2'b10;
    left_in = 0;
    #10;
    // Expect data_output to shift left and become 1010

    // Test case 4: Retain current value
    sel = 2'b00;
    #10;
    // Expect data_output to stay the same (1010)

    // Test case 5: Load new data again
    sel = 2'b11;
    data_input = 4'b0111;
    #10;
    // Expect data_output = 0111

    // Test case 6: Shift left with left_in = 1
    sel = 2'b10;
    left_in = 1;
    #10;
    // Expect data_output to shift left and become 1110

    // End simulation
    #10;
    $finish;
  end
endmodule
