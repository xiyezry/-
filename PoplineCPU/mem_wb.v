module mem_wb(  input clk,
                input rst,
                input[31:0] mem_inst,
                input[31:0] mem_ALUOUT,
                input[31:0] mem_MEMOUT,
                input mem_RegDst,
                input mem_MemtoReg,
                input mem_RegWrite,
                output reg[31:0] wb_inst,
                output reg[31:0] wb_ALUOUT,
                output reg[31:0] wb_MEMOUT,
                output reg wb_RegDst,
                output reg wb_MemtoReg,
                output reg wb_RegWrite);
    always @ (posedge clk) begin
        if(rst)
        begin
            wb_inst   <= 32'h00000000;
            wb_ALUOUT <= 32'h00000000;
            wb_MEMOUT <= 32'h00000000;
            wb_RegDst <= 0;
            wb_MemtoReg <= 0;
            wb_RegWrite <= 0;
        end
        else
        begin
            wb_inst <= mem_inst;
            wb_ALUOUT <= mem_ALUOUT;
            wb_MEMOUT <= mem_MEMOUT;
            wb_RegDst <= mem_RegDst;
            wb_MemtoReg <= mem_MemtoReg;
            wb_RegWrite <= mem_RegWrite;
        end
    end
endmodule