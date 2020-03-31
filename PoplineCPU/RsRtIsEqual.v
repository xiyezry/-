module RsRtIsEqual(IsBeq,IsBne,RFDataOut1,RFDataOut2,Branch);
    input IsBeq;
    input IsBne;
    input[31:0] RFDataOut1;
    input[31:0] RFDataOut2;
    output reg Branch;

    always @(*)
    begin
        if (IsBeq) begin
            if(RFDataOut1==RFDataOut2)
                Branch = 1;
            else
                Branch = 0;
        end else if (IsBne) begin
            if(RFDataOut1!=RFDataOut2)
                Branch = 1;
            else
                Branch = 0;
        end
        else
            Branch = 0;
    end
endmodule