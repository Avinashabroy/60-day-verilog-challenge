module t_ff (
    input t, 
    input clk, 
    input clear, 
    output reg q
);
    always @(posedge clk or posedge clear) begin
        if (clear)begin
            q <= 1'b0; 
        end else begin 
            q <= (t ? ~q : q);
			end	
    end
endmodule
