module d_flip_flop_fsm(
    input wire clk,    
    input wire rst,    
    input wire d,      
    output reg q       
);

    // Define states
    parameter STATE_0 = 1'b0;  
    parameter STATE_1 = 1'b1; 
	 
    reg current_state, next_state;
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= STATE_0;  
        else
            current_state <= next_state;
    end
    
    always @(*) begin
        case (current_state)
            STATE_0: begin
                if (d) begin
                    next_state <= STATE_1;
                    q <= 1;
                end else begin
                    next_state <= STATE_0;
                    q <= 0;
                end
            end
            STATE_1: begin
                if (!d) begin
                    next_state <= STATE_0;
                    q <= 0;
                end else begin
                    next_state <= STATE_1;
                    q <= 1;
                end
            end
        endcase
    end
endmodule
