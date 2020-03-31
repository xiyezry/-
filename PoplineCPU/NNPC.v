module NNPC(PCPLUS4,PCBranch,PCJump,Branch,Jump,NNPC);
    input[31:0] PCPLUS4;
    input[31:0] PCBranch;
    input[31:0] PCJump;
    input Branch;
    input Jump;
    output reg[31:0] NNPC;

    always @(*) begin
        if (Branch) begin
            NNPC = PCBranch;
        end
        else if (Jump) begin
            NNPC = PCJump;
        end
        else
            NNPC = PCPLUS4;
    end
endmodule

