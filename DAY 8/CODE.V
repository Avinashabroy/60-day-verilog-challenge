// HALF SUB
module half_sub_bv(a,b,diff,bor);
input a,b;
output reg diff,bor;
always @(a or b) begin 
if (a-b == 0) begin
diff=0;
bor=0;
end
else if (a-b == -1) begin
diff=1;
bor=1;
end
else if (a-b == 1) begin
diff=1;
bor=0;
end
else begin
diff=0;
bor=0;
end
end
endmodule
