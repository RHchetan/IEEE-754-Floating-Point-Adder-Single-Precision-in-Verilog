`include "ieee754add.v"
module ieee754add_tb;
reg [31:0] operand_1;    
reg [31:0] operand_2;
wire [31:0] sum;

ieee754add mod0(operand_1,operand_2,sum);
initial
begin
operand_1 = 32'b01000001000100000000000000000000; // 9.0        
operand_2 = 32'b01000000101000000000000000000000; // 5.0


#2
operand_1 = 32'b11000000101000000000000000000000; // -5.0        
operand_2 = 32'b11000000100000000000000000000000; // -4.0;

#4
operand_1 = 32'b01000000000000000000000000000000; // +2.0
operand_2 = 32'b11000000101000000000000000000000; // -5.0
         

end
 always
 begin
#9 
$finish;
end  

initial
$monitor($time,"\n,  operand_1=%b\n,  operand_2=%b\n,====================\n,sum=%b\n",operand_1,operand_2,sum);
endmodule
