// Code your design here
module jkff(
  input [1:0] jk,
  input clk,
  output reg q,
  output wire qb);
  always@(posedge clk)begin
    case(jk)
      2'b00:q<=q;
      2'b01:q<=0;
      2'b10:q<=1;
      2'b11:q<=~q;
    endcase
  end
    assign qb = ~q;
    endmodule
