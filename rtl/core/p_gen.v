module p_gen(

			input				y_sub,
			input				y,
			input				y_add,
			input		[67:0]	x,
			output		[67:0]	p,
			output				c
			

);

///y+1,y,y-1///
wire sel_negative,sel_double_negative,sel_positive,sel_double_positive;
wire [67:0]x_sub;

assign x_sub = {x,1'b0};

assign sel_negative =  y_add & (y & ~y_sub | ~y & y_sub);
assign sel_positive = ~y_add & (y & ~y_sub | ~y & y_sub);
assign sel_double_negative =  y_add & ~y & ~y_sub;
assign sel_double_positive = ~y_add &  y &  y_sub;


assign p = 	sel_negative 		? ~x		:
			sel_double_negative ? ~x_sub	:
			sel_positive 		?  x 		: 
			sel_double_positive ?  x_sub	: 'b0;
			
assign c = sel_negative | sel_double_negative;
endmodule		
			
			
