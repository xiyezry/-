module if_id(clk,rst,flush,ifid_write,if_pc,if_inst,if_pcplus4,id_pc,id_inst,id_pcplus4);

input clk;
input rst;
input flush;
input ifid_write;
input[31:0] if_pc;
input[31:0] if_inst;
input[31:0] if_pcplus4;
output reg[31:0] id_pc;
output reg[31:0] id_inst;
output reg[31:0] id_pcplus4;

always @ (posedge clk,posedge rst) begin
    if(rst||flush)
    begin
        id_pc <=32'h00000000;
        id_inst<=32'h00000000;
        id_pcplus4<=32'h00000000;
    end
    else if(ifid_write==1)
    begin
        id_pc <= if_pc;
        id_inst <= if_inst;
        id_pcplus4 <= if_pcplus4;
    end
end
endmodule
