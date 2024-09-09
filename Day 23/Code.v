module D_latch( input D,EN,output reg Q);
always @(EN,D)
if(EN) Q<=D;


endmodule
