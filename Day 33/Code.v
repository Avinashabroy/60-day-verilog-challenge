module T_ff_FSM (
   input clk, rst, t,
   output reg q
);
   // State encoding
   localparam s0 = 1'b0,  // State where q = 0
              s1 = 1'b1;  // State where q = 1

   reg state, next_state;
   
   // State transition on clock or reset
   always @(posedge clk or posedge rst) begin
      if (rst) begin
         state <= s0;  // Reset to state s0 (q = 0)
         q <= 0;
      end else begin
         state <= next_state;  // Move to next state
         case (next_state)
            s0: q <= 0;  // Assign output q based on the state
            s1: q <= 1;
         endcase
      end
   end
   
   // Next state logic
   always @(*) begin
      case (state)
         s0: begin
            if (t == 1'b1) begin
               next_state = s1;  // Toggle to state s1
            end else begin
               next_state = s0;  // Stay in s0
            end
         end
         
         s1: begin
            if (t == 1'b1) begin
               next_state = s0;  // Toggle back to s0
            end else begin
               next_state = s1;  // Stay in s1
            end
         end
         
         default: begin
            next_state = s0;  // Default to state s0
         end
      endcase
   end
endmodule
