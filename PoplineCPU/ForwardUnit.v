//旁路单元
module ForwardUnit(mem_RegWrite,wb_RegWrite,mem_RegisterRd,wb_RegisterRd,exe_Rs,exe_Rt,ForwardA,ForwardB);

    input mem_RegWrite;
    input wb_RegWrite;
    input[4:0] mem_RegisterRd;
    input[4:0] wb_RegisterRd;
    input[4:0] exe_Rs;
    input[4:0] exe_Rt;
    output reg[1:0] ForwardA;
    output reg[1:0] ForwardB;

    always @(*)
    begin
        if(mem_RegWrite&&mem_RegisterRd!=0&&mem_RegisterRd==exe_Rs)
            ForwardA=2'b10;
        else if(wb_RegWrite&&wb_RegisterRd!=0&&wb_RegisterRd==exe_Rs)
            ForwardA=2'b01;
        else
            ForwardA=2'b00;
        if(mem_RegWrite&&mem_RegisterRd!=0&&mem_RegisterRd==exe_Rt)
            ForwardB=2'b10;
        else if(wb_RegWrite&&wb_RegisterRd!=0&&wb_RegisterRd==exe_Rt)
            ForwardB=2'b01;
        else
            ForwardB=2'b00;
    end
endmodule


