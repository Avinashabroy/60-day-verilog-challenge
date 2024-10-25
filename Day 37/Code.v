module sipo(clk, rst, si, q);
  input clk, rst;
  input si;
  output reg [3:0] q;

  always @(posedge clk or posedge rst)
    begin 
      if (rst)
        q <= 4'b0000;  
      else
        begin
          q[0] <= si;
          q[1] <= q[0];
          q[2] <= q[1];
          q[3] <= q[2];
        end
    end
endmodule
