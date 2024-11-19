module Simple_4bit_counter (
    input wire clk,         // Clock signal
    input wire rst,         // Active-low reset signal
    input wire [3:0] data,  // 4-bit data input for manual load
    output reg [3:0] counter // 4-bit counter output
);
    always @(posedge clk) begin
        if (!rst) begin
            counter <= 4'b0;  // Reset counter to 0 on active-low reset
        end else begin
            counter <= counter + 1; // Increment counter
        end
    end
endmodule
method 2
module Simple_4bit_counter (
    input wire clk,         // Clock signal
    input wire rst,         // Active-low reset signal
    input wire load,        // Load control signal
    input wire [3:0] data,  // 4-bit data input for manual load
    output reg [3:0] counter // 4-bit counter output
);
    always @(posedge clk) begin
        if (!rst) begin
            counter <= 4'b0;  // Reset counter to 0 on active-low reset
        end else if (load) begin
            counter <= data; // Load external data
        end else begin
            counter <= counter + 1; // Increment counter
        end
    end
endmodule
