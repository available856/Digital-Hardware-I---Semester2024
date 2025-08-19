module alu_tb ();
  reg [31:0] op1, op2;
  reg [3:0] alu_op;
  wire zero;
  wire [31:0] result;
  
  parameter[3:0] ALUOP_AND = 4'b0000,
                 ALUOP_OR  = 4'b0001,
                 ALUOP_ADD = 4'b0010,
   				 ALUOP_SUB = 4'b0110,
                 ALUOP_LET = 4'b0111,
  				 ALUOP_LSR = 4'b1000,
  	             ALUOP_LSL = 4'b1001,
  				 ALUOP_ASR = 4'b1010,
  				 ALUOP_XOR = 4'b1101;
  
  alu ALU_TB (zero, result, op1, op2, alu_op);
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    op1 = 32'b01111111110000111111111111111111; 
    op2 = 32'b11111111111111111111111111110001; 
    alu_op = ALUOP_ASR;
    #20 $display("result = %d, op1 = %b, op2 = %b, aluop = %b, zero = %b", result, op1, op2, alu_op, zero); 
  end
  
endmodule