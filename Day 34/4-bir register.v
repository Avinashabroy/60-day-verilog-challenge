module simple_register (
    input wire clk,        
    input wire reset,        
    input wire enable,       
    input wire [3:0] d_in,   
    output reg [3:0] q_out   
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_out <= 4'b0000;
        end else if (enable) begin
            q_out <= d_in;
        end
    end

endmodule
