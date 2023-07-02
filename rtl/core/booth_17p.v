module booth_17p(			
			input		[31:0]		x,			//multiplicand
			input		[31:0]		y,			//multiplier
			
			input					signed_flag,

			output	[17*68-1:0]		p_17x68,
			output	[16:0]			c_17	

);
//////1.根据是否是有符号数进行扩展///////////////////
wire [67:0]x_68;
wire [33:0]y_34;

assign x_68 = signed_flag ? {{36{x[31]}},x} : {{36{1'b0}},x};
assign y_34 = signed_flag ? {{2{y[31]}},y} : {2'b0,y};			

wire [34:0]y_35;
assign y_35 = {y_34,1'b0};
 
/////2.




////3.例化17个部分积产生模块//////////////
wire [67:0]p[0:16];

genvar i,j;
generate
for ( i=1;i<=17;i=i+1)
 begin
	p_gen u_pgen_i(

			.y_sub	(y_35[2*i-2]),
			.y		(y_35[2*i-1]),
			.y_add	(y_35[2*i]),
			.x		(x_68<<2*(i-1)),
			.p		(p[i-1]),
			.c      (c_17[i-1])
);
 end

for( j=0;j<17;j=j+1) 
 begin :pack
   	assign p_17x68[68*j+67 : 68*j] = p[j];
 end
 endgenerate


endmodule
