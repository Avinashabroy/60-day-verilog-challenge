module tb_D_latch;
  // Inputs
  reg D;
  reg EN;
  
  // Outputs
  wire Q;
  
  // Instantiate the D latch module
  D_latch uut (
    .D(D),
    .EN(EN),
    .Q(Q)
  );
  
  // Test stimulus
  initial begin
    // Create a VCD file for waveform viewing
    $dumpfile("dump.vcd");   // Specify the VCD file name
    $dumpvars(0, tb_D_latch); // Dump all variables of the testbench

    // Initialize inputs
    D = 0;
    EN = 0;
    
    // Display header
    $display("Time\tEN\tD\tQ");
    $monitor("%0t\t%b\t%b\t%b", $time, EN, D, Q);
    
    // Apply test cases
    #10 D = 1; EN = 0;  // D = 1, EN = 0, no change in Q
    #10 D = 0; EN = 1;  // D = 0, EN = 1, Q should change to 0
    #10 D = 1; EN = 1;  // D = 1, EN = 1, Q should change to 1
    #10 D = 0; EN = 0;  // D = 0, EN = 0, Q remains unchanged
    #10 D = 1; EN = 0;  // D = 1, EN = 0, no change in Q
    #10 D = 1; EN = 1;  // D = 1, EN = 1, Q should change to 1

    #10 $finish;         // End the simulation
  end
endmodule
