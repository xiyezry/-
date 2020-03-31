module PC( clk, rst,PCWrite, NPC, PC);

  input              clk;
  input              rst;
  input              PCWrite;
  input       [31:0] NPC;
  output reg  [31:0] PC;

  always @(posedge clk, posedge rst)
    if (rst) 
      PC <= 32'h0000_0000;
    else if(PCWrite==1)
      PC <= NPC;
      
endmodule

