module PCBranch(PCPLUS4,IMM,PCBranch);
    input[31:0] PCPLUS4;
    input[15:0] IMM;
    output reg[31:0] PCBranch;

    always @(*) begin
        PCBranch = PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00};
    end
endmodule