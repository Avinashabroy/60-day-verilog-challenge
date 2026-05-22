// sync_2ff.v
// Generic 2-flop synchronizer for crossing clock domains safely
// Only 1 bit changes per cycle (Gray code) so metastability resolves correctly

module sync_2ff #(
    parameter WIDTH = 5
)(
    input  wire             clk,
    input  wire             rst,
    input  wire [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q
);
    reg [WIDTH-1:0] sync1;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sync1 <= 0;
            q     <= 0;
        end else begin
            sync1 <= d;    // Stage 1: may be metastable
            q     <= sync1; // Stage 2: metastability resolved
        end
    end

endmodule
