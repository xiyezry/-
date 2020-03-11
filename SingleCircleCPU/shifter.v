module Shifter(orignial,index,right,arith,result);
	input right;          //0为左移，1为右移
	input arith;          //0为逻辑移动、1为算数移动
	input[31:0] orignial; //原始输入数据
	input[4:0] index;     //移动位数	  
	output[31:0] result;  //移位后结果
	
	reg[31:0] result;
	
	always@(*) begin
	if(!right)
		begin
		result = orignial<<index;
		end
	else if(!arith)
		begin
			result = orignial>>index;
		end
	else
		begin
			result = $signed(orignial)>>>index;
		end
	end
endmodule