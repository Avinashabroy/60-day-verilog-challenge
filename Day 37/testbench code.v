module sipo_tb;
  reg clk, rst, si;
  wire [3:0] q;

  // Instantiate the SIPO module
  sipo uut (
    .clk(clk),
    .rst(rst),
    .si(si),
    .q(q)
  );

  // Clock generation
  initial
    clk = 0;
  always #5 clk = ~clk;

  // Test sequence with waveform generation
  initial begin
    // Initiate VCD file creation to capture the mosaic of transitions
    $dumpfile("dump.vcd"); // Defines the VCD file
    $dumpvars(0, sipo_tb); // Records all variables in the testbench
    
    // Display output header
    $display("Time\tclk\trst\tsi\tq");
    $monitor("%0d\t%b\t%b\t%b\t%b", $time, clk, rst, si, q);
    
    // Initialize signals and apply a series of inputs to delve into the shift behavior
    rst = 1; si = 0;
    #10 rst = 0; 
    
    // Sequence to check shift operation
    si = 1; #10;
    si = 0; #10;
    si = 1; #10;
    si = 1; #10;
    si = 0; #10;
    si = 1; #10;
    
    // Apply reset again to reinitialize
    rst = 1; #10;
    rst = 0; #10;

    // End the simulation
    $finish;
  end
endmodule
