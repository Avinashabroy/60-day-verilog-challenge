module PISO(
  input wire clk,
  input wire reset,
  input wire load,
  input wire [7:0] pdata,
  output reg sdata
);

  reg [7:0] shift_reg;

  always @(posedge clk or posedge reset)
  begin
    if (reset)
      shift_reg <= 8'b0;        
    else if (load)
      shift_reg <= pdata;          
    else
      shift_reg <= shift_reg >> 1; 
  end

  always @(posedge clk or posedge reset)
  begin
    if (reset)
      sdata <= 1'b0;              
    else
      sdata <= shift_reg[0];       
  end

endmodule
