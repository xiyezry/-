//right 1:右移 0：左移
//index 1:25-21 0:10-6
//arith 1:1补空 0:0补空

module Shifter(orignial,index,right,arith,result);

	input[31:0] orignial;
	input[4:0] index;
	input right,arith;
	
	output[31:0] result;
	
	reg[31:0] result;
	
	always@*
	begin
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