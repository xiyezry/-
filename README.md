# 计算机组成原理课程设计
## 第一部分 单周期处理器
### 1：任务要求
实现能够支持一下指令的单周期处理器
add/sub/and/or/slt/sltu/addu/subu
addi/ori/lw/sw/beq
j/jal
sll/nor/lui/slti/bne/andi/srl/sllv/srlv/jr/jalr
xor/sra/srav
lb/lh/lbu/lhu/sb/sh (数据在内存中以小端形式存储little endian)

更新公告：
2020年3月10日 基本实现以上指令并通过代码测试，有少量非严重bug待修复；注释待完善。
2020年3月11日 修复目前已知bug；完善注释 且通过测试代码测试
