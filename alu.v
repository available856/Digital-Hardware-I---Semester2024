module alu (output reg zero,
            output reg [31:0] result,
            input wire [31:0] op1, op2,
   	        input wire [3:0] alu_op);
  
 //encoding the operations
  parameter[3:0] ALUOP_AND = 4'b0000,
                 ALUOP_OR  = 4'b0001,
                 ALUOP_ADD = 4'b0010,
   				 ALUOP_SUB = 4'b0110,
                 ALUOP_LET = 4'b0111,
  				 ALUOP_LSR = 4'b1000,
  	             ALUOP_LSL = 4'b1001,
  				 ALUOP_ASR = 4'b1010,
  				 ALUOP_XOR = 4'b1101;
 
  //creating useful temporary variables for next use
  reg signed [31:0] tmp1, tmp2;
  reg [4:0] tmp3; //creating a temporary variable to reduce size
 
  //implementing a combinational system responding to any input
  always @ (op1, op2, alu_op)
    begin
      //initialization
      zero = 0; 
      tmp1 = ~(op1-1); //converting a 2's complement number
      tmp2 = ~(op2-1); //back to binary for specific operations
      tmp3 = tmp2;
      
      
      case (alu_op)
        ALUOP_AND : result = op1 & op2;
        ALUOP_OR  : result = op1 | op2;
        ALUOP_ADD : result = op1 + op2;
        ALUOP_SUB : result = op1 - op2;
        ALUOP_LET : result = ~(tmp1 < tmp2)+1; //converting result back to 2's complement
        ALUOP_LSR : result = op1 >> tmp3;
        ALUOP_LSL : result = op1 << tmp3;
        ALUOP_ASR : result = $unsigned (~(tmp1 >>> tmp3)); //converting result back to unsigned 2's complement
        ALUOP_XOR : result = op1 ^ op2;
     	default   : result = 0;
      endcase
 
      if (result == 0)
        zero = 1; //condition of triggering "zero"
    end
  
  
endmodule