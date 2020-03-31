module PCJump(PCPLUS4,JAddOffset,RegJump,FullJump,PCJump);
    input[31:0] PCPLUS4;
    input[25:0] JAddOffset;
    input[31:0] RegJump;
    input FullJump;
    output reg[31:0] PCJump;

    always @(*)begin
        if(FullJump)
            PCJump = RegJump;
        else
            PCJump = {PCPLUS4[31:28], JAddOffset[25:0], 2'b00};
    end
endmodule