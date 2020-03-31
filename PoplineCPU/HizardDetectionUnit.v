module HizardDetectionUnit(rst,inst,Branch,Jump,id_RegisterRs,id_RegisterRt,exe_RegisterRt,exe_MemRead,PCWrite,IFIDWrite,Stall,flush);
    input rst;
    input[31:0] inst;
    input Branch;
    input Jump;
    input[4:0] exe_RegisterRt;
    input[4:0] id_RegisterRs;
    input[4:0] id_RegisterRt;
    input exe_MemRead;
    output reg PCWrite;
    output reg IFIDWrite;
    output reg Stall;
    output reg flush;

    always @(posedge rst)begin
        if(rst) begin
            PCWrite = 1;
            IFIDWrite = 1;
            Stall = 0;
            flush = 0;
        end
    end
    always @(*)begin
        if(exe_MemRead&&((exe_RegisterRt==id_RegisterRs)||(exe_RegisterRt==id_RegisterRt)))
        begin
            PCWrite=0;
            IFIDWrite=0;
            Stall=1;
            flush = 0;
        end
        else if (Branch) begin
            PCWrite = 0;
            IFIDWrite = 0;
            Stall = 1;
            flush = 0;
        end
        else if(Branch||Jump)
        begin
            flush = 1;
        end
        else //已修复BUG：最初没有这个 导致无法从异常状态中回复正常状态 
        begin
            PCWrite = 1;
            IFIDWrite = 1;
            Stall = 0;
            flush = 0;
        end
    end
endmodule