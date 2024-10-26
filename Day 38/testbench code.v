`timescale 1ns/1ps

module PISO_tb;

  // Testbench signals
  reg clk;
  reg reset;
  reg load;
  reg [7:0] pdata;
  wire sdata;

  // Instantiate the PISO module
  PISO uut (
    .clk(clk),
    .reset(reset),
    .load(load),
    .pdata(pdata),
    .sdata(sdata)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
  end

  // Test sequence
  initial begin
    // Initialize signals
    reset = 1;
    load = 0;
    pdata = 8'b1010_1101;

    // Apply reset
    #10;
    reset = 0;

    // Load data into the shift register
    #10;
    load = 1;
    #10;
    load = 0;

    // Observe shifting data
    #80;

    // Apply reset again to clear register
    #10;
    reset = 1;
    #10;
    reset = 0;

    // Load new data
    pdata = 8'b1100_1110;
    #10;
    load = 1;
    #10;
    load = 0;

    // Observe second shift sequence
    #80;
    
    // End simulation
    $finish;
  end

  // Monitor the outputs and generate VCD file
  initial begin
    $dumpfile("dump.vcd");    // Specify the name of the VCD file
    $dumpvars(0, PISO_tb);     // Dump all variables in the testbench scope
    $monitor("Time=%0t | reset=%b | load=%b | pdata=%b | sdata=%b", 
              $time, reset, load, pdata, sdata);
  end

endmodule
