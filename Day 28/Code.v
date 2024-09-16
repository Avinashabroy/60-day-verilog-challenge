module MasterSlaveDFF (
    input D,      // Data input
    input clk,    // Clock input
    input reset,  // Asynchronous reset
    output reg Q  // Output
);

    reg master; // Internal signal for the master latch

    // Master latch (active when clk is low)
    always @(posedge reset or negedge clk) begin
        if (reset)
            master <= 0;
        else
            master <= D;
    end

    // Slave latch (active when clk is high)
    always @(posedge reset or posedge clk) begin
        if (reset)
            Q <= 0;
        else
            Q <= master;
    end

endmodule
