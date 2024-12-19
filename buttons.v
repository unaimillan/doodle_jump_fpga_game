module buttons(input clk, right_button, left_button, output reg [8:0] shift_h, output reg sprite_choice);
integer shift_cnt;
always @(posedge clk)
begin
		//button control
		if (!right_button) 
			begin
			shift_cnt = shift_cnt + 1;
			sprite_choice = 0;
			end
		if (!left_button)
			begin
			shift_cnt = shift_cnt - 1;
			sprite_choice = 1;
			end
		shift_h = shift_cnt/100_000;
		//---
end
endmodule