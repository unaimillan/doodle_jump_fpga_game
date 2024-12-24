module game
(input clk, input [8:0] shift_h, output reg [8:0] platform_const_h_0, platform_const_v_0, platform_const_h_1, 
platform_const_v_1, platform_const_h_2, platform_const_v_2, platform_const_h_3, platform_const_v_3, ground_h, ground_v, jump, output reg game_over);

integer platform_v [0:3], platform_h[0:3];

//constant shifts in platform positions
integer platform_const_v [0:3], platform_const_h [0:3];




//pixel counters with constant shifts
integer temp[0:3];
// 


integer paws_h, paws_v;

//constant values used for calculations
integer jump_height = 245; //the maximum height of the jump calculated with the formula h_max = v^^2/(2g)
integer doodle_height = 80; 
integer platform_width = 100;
integer platform_height = 30;
integer gravity = 5; //the constant g/2 = 5
integer velocity = 70;
integer t0 = 14; //the time when the jump ends
integer const = 3_000_000; //a large constant manually selected to make the jump slower 
//-----

//time counters for jumps
integer time_cnt = 0; 
integer time_c = 0; //time_cnt decreased by a constant

//time counters for platform movements
integer time_cnt_platform = 0;
integer t = 0;

integer lowest_platform = 0;
integer game = 0;
integer i = 0;
integer new_id = 0, old_id = 0;
integer temp_id = 0;

reg vulnerability;
reg collision; //to move the platfoms
reg platform_collision; //to climb on the platform

always @(posedge clk)
begin
		ground_h = 600;
		ground_v = 680;
		//doing some silly looking stuff because verlog doesn't allow us to input/output arrays normally
		platform_const_v_0 = platform_const_v[0];
		platform_const_v_1 = platform_const_v[1];
		platform_const_v_2 = platform_const_v[2];
		platform_const_v_3 = platform_const_v[3];

		platform_const_h_0 = platform_const_h[0];
		platform_const_h_1 = platform_const_h[1];
		platform_const_h_2 = platform_const_h[2];
		platform_const_h_3 = platform_const_h[3];
		//decreasing time counter by a big constant
		time_c = time_cnt / const;
		//calculating current jump position with h = vt - gt^^2/2,
		//where g/2 = 5
		jump = velocity * time_c - gravity * time_c * time_c;
		time_cnt = time_cnt + 1;
		
	
		//setting counter to zero after one jumping cycle finishes
		if ((time_c >= t0 && game == 0) || platform_collision == 1) 
			begin
			time_cnt = 0;
			end
		//indicating that collision is possible when doodle is falling after the jump
		if (time_cnt > ((t0 * const)/ 2)) vulnerability = 1;
		else vulnerability = 0;
		
		//randomly calculated platform constant shifts
		if (game == 0)
			begin
			platform_const_v[0] = 525/*$urandom_range(ground_v - jump_height - 40 + 80, ground_v - jump_height - 10 + 80)*/;
			platform_const_h[0] = 400/*$urandom_range(360, 570)*/;
			for (i = 1; i < 4; i = i + 1)
				begin
				platform_const_v[i] = platform_const_v[i - 1] - 235;
				platform_const_h[i] = platform_const_h[i - 1] + 60;
   			end
			end
			
		//saving the position of the platforms before movement
		if (collision == 0) 
			begin
			for (i = 0; i < 4; i = i + 1)
				begin
				temp[i] = platform_const_v[i];
				end
			end
			
		paws_v = ground_v - jump + doodle_height;
		paws_h = ground_h + shift_h;	
		//if ((paws_v - doodle_height) > 768 ) game_over = 1;
		
		//setting the collison for movement to 1 if the doodle jumped higher
		//and platform_collision to 1 whether it jumped higher or stayed on the same platform
		if (vulnerability == 1)
			begin
			new_id = ((lowest_platform + 1) == 4) ? 0: (lowest_platform + 1);
			new_id = (game == 0) ? lowest_platform: new_id;
			if ((platform_const_v[new_id] - paws_v) >= 0 && (platform_const_v[new_id] - paws_v) <= 10)
				begin
				if ((paws_h - platform_const_h[new_id]) > (-1 * doodle_height) && (paws_h - platform_const_h[new_id]) < platform_width)
					begin
					collision = 1;
					platform_collision = 1;
					ground_v = platform_const_v[new_id] - doodle_height;
					end
				end
			else if ((platform_const_v[lowest_platform] - paws_v) >= 0 && (platform_const_v[lowest_platform] - paws_v) <= 10)
				begin
				if ((paws_h - platform_const_h[lowest_platform]) > (-1 * doodle_height) && (paws_h - platform_const_h[lowest_platform]) < platform_width)
					begin
					platform_collision = 1;
					end
				end
			else platform_collision = 0;
			end
		else platform_collision = 0;
			
			
			//platform movement
			if (collision == 1) 
				begin
				time_cnt_platform =  time_cnt_platform + 1;
				t = time_cnt_platform / const;
				for (i = 0; i < 4; i = i + 1)
					begin
					platform_const_v[i] = temp[i] + (730 - temp[lowest_platform])/ 3 * t;
					end
				if (time_cnt_platform == 3 * const)
					begin
					time_cnt_platform = 0;
					collision = 0;
					old_id = lowest_platform;
					lowest_platform = new_id;
					if (game != 0) 
						begin
						temp_id = ((old_id - 1) < 0) ? 4 : (old_id - 1);
						platform_const_v[old_id] = platform_const_v[temp_id] - 235; //lowest platform respawn
						end
					else game = 1;
					end
				end
		
		
		
end
endmodule