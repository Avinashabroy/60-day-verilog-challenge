// Build a circuit with no inputs and one output. That output should always drive 1 (or logic high).
// Case 1: Using an `initial` Block
module constant_high (output reg out);
    // The `initial` block is executed once at the start of the simulation.
    // Here, it sets the output `out` to logic high (`1'b1`) when the simulation begins.
    initial begin 
        out = 1'b1;  // Set the output `out` to 1 (logic high).
    end
endmodule

// Case 2: Using a Continuous Assignment (`assign`)
module constant_high (output out);
    // The `assign` statement continuously drives the output `out` to logic high (`1'b1`).
    // The output is a wire (implicitly declared) because it is driven by a continuous assignment.
    assign out = 1'b1;  // Continuously assign logic high to `out`.
endmodule

// Case 3: Parameterized Output Value
module constant_high #(parameter HIGH_VALUE = 1'b1)(output out);
    // This module introduces a parameter `HIGH_VALUE` which can be set during module instantiation.
    // By default, `HIGH_VALUE` is set to `1'b1`, making the output logic high.
    // The `assign` statement continuously drives the output `out` with the value of `HIGH_VALUE`.
    assign out = HIGH_VALUE;  // Assign the value of `HIGH_VALUE` (default is 1) to `out`.
endmodule

// Case 4: Using an `always` Block
module constant_high (output reg out);
    // The `always @(*)` block is triggered whenever any of the signals it depends on changes.
    // Here, it continuously drives the output `out` to logic high (`1'b1`).
    // The output is declared as `reg` because it is driven inside a procedural block (`always`).
    always @(*) begin 
        out = 1'b1;  // Set the output `out` to 1 (logic high) continuously.
    end
endmodule

