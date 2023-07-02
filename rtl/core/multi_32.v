module multi_32(
			//input		 			clk,			
			//input		 			rst_n,			
			
			input		[31:0]		x,			//multiplicand
			input		[31:0]		y,			//multiplier
			
			input					signed_flag,
		
			output		[67:0]		result_o				
);
wire [17*68-1:0]	p_17x68;
wire [16:0]			c_17;
wire [13:0] c_group [0:68];

assign c_group[0] = c_17[13:0];
wire [67:0] s_wlc;
wire [67:0] c_wlc;

wire [16:0] walloc_in [0:67];
///////////unpack//////////////
  
 for(genvar i=0; i<68; i=i+1) begin: s68
	for(genvar j=0; j<17; j=j+1)begin: s17
		assign walloc_in[i][j] = p_17x68[68*j + i];
	end
  end


  
/////////////////////////////////////  
for(genvar n=0; n<68; n=n+1) begin: gen68walloc
    walloc_17  u_walloc_(			
		.src_in			(walloc_in[n]),			////17bits
		.cin			(c_group[n]),			////14bits
		.cout_group		(c_group[n+1]),			////14bits
		.cout			(c_wlc[n]),	
		.s              (s_wlc[n])
		);
    
  end
  
////////////////例化17个部分积产生模块/////////////
	

    booth_17p  u_booth_(			
		.x				(x),			
		.y				(y),			
		.signed_flag	(signed_flag),
		.p_17x68		(p_17x68),
		.c_17	        (c_17)
		);


////////////////结果输出///////////////////////
assign result_o = s_wlc + {c_wlc[66:0],c_17[14]} + c_17[15];     // c_wlc最高位舍弃 //并且c_17[16]==0


endmodule
