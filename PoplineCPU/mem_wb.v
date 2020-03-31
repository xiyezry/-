module mem_wb(  input clk,
                input rst,
                input[31:0] mem_inst,
                input[31:0] mem_ALUOUT,
                input[31:0] mem_MEMOUT,
                input[4:0] mem_RegisterRd,
                input mem_RegDst,
                input mem_MemtoReg,
                input mem_RegWrite,
                input mem_call,
                input[31:0] mem_pcplus4,
                output reg[31:0] wb_inst,
                output reg[31:0] wb_ALUOUT,
                output reg[31:0] wb_MEMOUT,
                output reg[4:0] wb_RegisterRd,
                output reg wb_RegDst,
                output reg wb_MemtoReg,
                output reg wb_RegWrite,
                output reg wb_call,
                output reg[31:0] wb_pcplus4);
    always @ (posedge clk,posedge rst) begin
        if(rst)
        begin
            wb_inst   <= 32'h00000000;
            wb_ALUOUT <= 32'h00000000;
            wb_MEMOUT <= 32'h00000000;
            wb_RegisterRd <= 5'b00000;
            wb_RegDst <= 0;
            wb_MemtoReg <= 0;
            wb_RegWrite <= 0;
            wb_call <=0;
            wb_pcplus4 <=32'h00000000;
        end
        else
        begin
            wb_inst <= mem_inst;
            wb_ALUOUT <= mem_ALUOUT;
            wb_MEMOUT <= mem_MEMOUT;
            wb_RegisterRd <= mem_RegisterRd;
            wb_RegDst <= mem_RegDst;
            wb_MemtoReg <= mem_MemtoReg;
            wb_RegWrite <= mem_RegWrite;
            wb_call <= mem_call;
            wb_pcplus4 <= mem_pcplus4;
        end
    end
endmodule