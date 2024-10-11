module shift_register
   #(parameter N = 8)
   (
      input wire clk,
      input wire reset,
      input wire S_in,
      output wire S_out
   );
   
   reg [N-1:0] r_reg;  
   wire [N-1:0] r_next;  

   // Sequential logic for shifting
   always @(posedge clk or posedge reset) begin
      if (reset)
         r_reg <= 0;  
      else
         r_reg <= r_next; 
   end

   assign r_next = {r_reg[N-2:0], S_in};  // Shift left and add S_in to LSB

   assign S_out = r_reg[N-1];  // Output the MSB

endmodule
