//ID阶段旁路单元
module IDForwardUnit(exe_RegWrite,mem_RegWrite,exe_RegisterRd,mem_RegisterRd,RFR1,RFR2,ForwardC,ForwardD);

    input exe_RegWrite;
    input mem_RegWrite;
    input[4:0] exe_RegisterRd;
    input[4:0] mem_RegisterRd;
    input[4:0] RFR1;
    input[4:0] RFR2;
    output reg[1:0] ForwardC;
    output reg[1:0] ForwardD;

    always@(*)
    begin
        
        if(exe_RegWrite&&exe_RegisterRd!=0&&exe_RegisterRd==RFR1)
            ForwardC=2'b10;
        else if(mem_RegWrite&&mem_RegisterRd!=0&&mem_RegisterRd==RFR1)
            ForwardC=2'b01;
        else
            ForwardC=2'b00;
        if(exe_RegWrite&&exe_RegisterRd!=0&&exe_RegisterRd==RFR2)
            ForwardD=2'b10;
        else if(mem_RegWrite&&mem_RegisterRd!=0&&mem_RegisterRd==RFR2)
            ForwardD=2'b01;
        else
            ForwardD=2'b00;
    end
endmodule