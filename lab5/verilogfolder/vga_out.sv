/*
VGA output
Draws grid and tokens
Includes sync module to sync output signal to the screen

EE371 Lab5
Andrique Liue, Emraj Sidhu, Nikhil Grover
*/

module vga_out(game_data, empty, clk, sys_clk, reset, 
				vga_horiz_sync, vga_vert_sync, vga_r,
				vga_g, vga_b);

				input [41:0] game_data; //determines which player is occupying a spot
				input [41:0] empty; //is spot empty
				input clk, sys_clk, reset;

				output vga_horiz_sync, vga_vert_sync;
				output reg vga_r, vga_g, vga_b;

				wire display;
				wire [9:0] counterHoriz;
				wire [9:0] counterVert; 
				reg [9:0] positionX = 60;
				reg [9:0] positionY = 60;
				wire lines, p1, p2;

				//Sequential logic to load colors on screen
				always @(posedge sys_clk) begin

					vga_r <= p1 & display;
					vga_b <= p2 & display;
					vga_g <= lines & display;
				end

				vga_sync sync(.clk(clk), .reset(reset), .vga_horiz_sync(vga_horiz_sync), .vga_vert_sync(vga_vert_sync), .display(display), .counterHoriz(counterHoriz), .counterVert(counterVert));

        		// green(create grid)
        		assign lines = 
                        (counterHoriz >= 38 && counterHoriz <= 42) || 
                        (counterHoriz >= 118 && counterHoriz <= 122) || 
                        (counterHoriz >= 198 && counterHoriz <= 202) ||
                        (counterHoriz >= 278 && counterHoriz <= 282) ||
                        (counterHoriz >= 358 && counterHoriz <= 362) ||
                        (counterHoriz >= 438 && counterHoriz <= 442) ||
                        (counterHoriz >= 518 && counterHoriz <= 522) ||
                        (counterHoriz >= 598 && counterHoriz <= 602) ||
                        ((counterHoriz >= 38 && counterHoriz <= 602) && (
                        (counterVert >= 75 && counterVert <= 79) || 
                        (counterVert >= 155 && counterVert <= 159) ||
                        (counterVert >= 235 && counterVert <= 239) ||
                        (counterVert >= 315 && counterVert <= 319) ||
                        (counterVert >= 395 && counterVert <= 399) ||
                        (counterVert >= 475 && counterVert <= 479)));
        
		        //red squares
		        assign p1 = 
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 410 && counterVert <= 464 && (empty[0]==1) && (game_data[0]==0)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 410 && counterVert <= 464 && (empty[1]==1) && (game_data[1]==0)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 410 && counterVert <= 464 && (empty[2]==1) && (game_data[2]==0)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 410 && counterVert <= 464 && (empty[3]==1) && (game_data[3]==0)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 410 && counterVert <= 464 && (empty[4]==1) && (game_data[4]==0)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 410 && counterVert <= 464 && (empty[5]==1) && (game_data[5]==0)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 410 && counterVert <= 464 && (empty[6]==1) && (game_data[6]==0)) ||
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 330 && counterVert <= 384 && (empty[7]==1) && (game_data[7]==0)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 330 && counterVert <= 384 && (empty[8]==1) && (game_data[8]==0)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 330 && counterVert <= 384 && (empty[9]==1) && (game_data[9]==0)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 330 && counterVert <= 384 && (empty[10]==1) && (game_data[10]==0)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 330 && counterVert <= 384 && (empty[11]==1) && (game_data[11]==0)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 330 && counterVert <= 384 && (empty[12]==1) && (game_data[12]==0)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 330 && counterVert <= 384 && (empty[13]==1) && (game_data[13]==0)) ||
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 250 && counterVert <= 304 && (empty[14]==1) && (game_data[14]==0)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 250 && counterVert <= 304 && (empty[15]==1) && (game_data[15]==0)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 250 && counterVert <= 304 && (empty[16]==1) && (game_data[16]==0)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 250 && counterVert <= 304 && (empty[17]==1) && (game_data[17]==0)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 250 && counterVert <= 304 && (empty[18]==1) && (game_data[18]==0)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 250 && counterVert <= 304 && (empty[19]==1) && (game_data[19]==0)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 250 && counterVert <= 304 && (empty[20]==1) && (game_data[20]==0)) ||
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 170 && counterVert <= 224 && (empty[21]==1) && (game_data[21]==0)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 170 && counterVert <= 224 && (empty[22]==1) && (game_data[22]==0)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 170 && counterVert <= 224 && (empty[23]==1) && (game_data[23]==0)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 170 && counterVert <= 224 && (empty[24]==1) && (game_data[24]==0)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 170 && counterVert <= 224 && (empty[25]==1) && (game_data[25]==0)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 170 && counterVert <= 224 && (empty[26]==1) && (game_data[26]==0)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 170 && counterVert <= 224 && (empty[27]==1) && (game_data[27]==0)) ||                        
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 90 && counterVert <= 144 && (empty[28]==1) && (game_data[28]==0)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 90 && counterVert <= 144 && (empty[29]==1) && (game_data[29]==0)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 90 && counterVert <= 144 && (empty[30]==1) && (game_data[30]==0)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 90 && counterVert <= 144 && (empty[31]==1) && (game_data[31]==0)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 90 && counterVert <= 144 && (empty[32]==1) && (game_data[32]==0)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 90 && counterVert <= 144 && (empty[33]==1) && (game_data[33]==0)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 90 && counterVert <= 144 && (empty[34]==1) && (game_data[34]==0)) ||
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 10 && counterVert <= 64 && (empty[35]==1) && (game_data[35]==0)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 10 && counterVert <= 64 && (empty[36]==1) && (game_data[36]==0)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 10 && counterVert <= 64 && (empty[37]==1) && (game_data[37]==0)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 10 && counterVert <= 64 && (empty[38]==1) && (game_data[38]==0)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 10 && counterVert <= 64 && (empty[39]==1) && (game_data[39]==0)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 10 && counterVert <= 64 && (empty[40]==1) && (game_data[40]==0)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 10 && counterVert <= 64 && (empty[41]==1) && (game_data[41]==0));
        
		        // blue squares
		        assign p2 = 
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 410 && counterVert <= 464 && (empty[0]==1) && (game_data[0]==1)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 410 && counterVert <= 464 && (empty[1]==1) && (game_data[1]==1)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 410 && counterVert <= 464 && (empty[2]==1) && (game_data[2]==1)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 410 && counterVert <= 464 && (empty[3]==1) && (game_data[3]==1)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 410 && counterVert <= 464 && (empty[4]==1) && (game_data[4]==1)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 410 && counterVert <= 464 && (empty[5]==1) && (game_data[5]==1)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 410 && counterVert <= 464 && (empty[6]==1) && (game_data[6]==1)) ||
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 330 && counterVert <= 384 && (empty[7]==1) && (game_data[7]==1)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 330 && counterVert <= 384 && (empty[8]==1) && (game_data[8]==1)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 330 && counterVert <= 384 && (empty[9]==1) && (game_data[9]==1)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 330 && counterVert <= 384 && (empty[10]==1) && (game_data[10]==1)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 330 && counterVert <= 384 && (empty[11]==1) && (game_data[11]==1)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 330 && counterVert <= 384 && (empty[12]==1) && (game_data[12]==1)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 330 && counterVert <= 384 && (empty[13]==1) && (game_data[13]==1)) ||
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 250 && counterVert <= 304 && (empty[14]==1) && (game_data[14]==1)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 250 && counterVert <= 304 && (empty[15]==1) && (game_data[15]==1)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 250 && counterVert <= 304 && (empty[16]==1) && (game_data[16]==1)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 250 && counterVert <= 304 && (empty[17]==1) && (game_data[17]==1)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 250 && counterVert <= 304 && (empty[18]==1) && (game_data[18]==1)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 250 && counterVert <= 304 && (empty[19]==1) && (game_data[19]==1)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 250 && counterVert <= 304 && (empty[20]==1) && (game_data[20]==1)) ||
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 170 && counterVert <= 224 && (empty[21]==1) && (game_data[21]==1)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 170 && counterVert <= 224 && (empty[22]==1) && (game_data[22]==1)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 170 && counterVert <= 224 && (empty[23]==1) && (game_data[23]==1)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 170 && counterVert <= 224 && (empty[24]==1) && (game_data[24]==1)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 170 && counterVert <= 224 && (empty[25]==1) && (game_data[25]==1)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 170 && counterVert <= 224 && (empty[26]==1) && (game_data[26]==1)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 170 && counterVert <= 224 && (empty[27]==1) && (game_data[27]==1)) ||                        
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 90 && counterVert <= 144 && (empty[28]==1) && (game_data[28]==1)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 90 && counterVert <= 144 && (empty[29]==1) && (game_data[29]==1)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 90 && counterVert <= 144 && (empty[30]==1) && (game_data[30]==1)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 90 && counterVert <= 144 && (empty[31]==1) && (game_data[31]==1)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 90 && counterVert <= 144 && (empty[32]==1) && (game_data[32]==1)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 90 && counterVert <= 144 && (empty[33]==1) && (game_data[33]==1)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 90 && counterVert <= 144 && (empty[34]==1) && (game_data[34]==1)) ||
                        (counterHoriz >= 53 && counterHoriz <= 107 && counterVert >= 10 && counterVert <= 64 && (empty[35]==1) && (game_data[35]==1)) ||
                        (counterHoriz >= 133 && counterHoriz <= 187 && counterVert >= 10 && counterVert <= 64 && (empty[36]==1) && (game_data[36]==1)) ||
                        (counterHoriz >= 213 && counterHoriz <= 267 && counterVert >= 10 && counterVert <= 64 && (empty[37]==1) && (game_data[37]==1)) ||
                        (counterHoriz >= 293 && counterHoriz <= 347 && counterVert >= 10 && counterVert <= 64 && (empty[38]==1) && (game_data[38]==1)) ||
                        (counterHoriz >= 373 && counterHoriz <= 427 && counterVert >= 10 && counterVert <= 64 && (empty[39]==1) && (game_data[39]==1)) ||
                        (counterHoriz >= 453 && counterHoriz <= 507 && counterVert >= 10 && counterVert <= 64 && (empty[40]==1) && (game_data[40]==1)) ||
                        (counterHoriz >= 533 && counterHoriz <= 587 && counterVert >= 10 && counterVert <= 64 && (empty[41]==1) && (game_data[41]==1));

endmodule