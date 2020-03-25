module if_id(clk,rst,if_pc,if_inst,id_pc,id_inst);

input clk;
input rst;
input[31:0] if_pc;
input[31:0] if_inst;
output reg[31:0] id_pc;
output reg[31:0] id_inst;

always @ (posedge clk) begin
    if(rst)
    begin
        id_pc <=32'h00000000;
        id_inst<=32'h00000000;
    end
    else
    begin
        id_pc <= if_pc;
        id_inst <= if_inst;
    end
end
endmodule
