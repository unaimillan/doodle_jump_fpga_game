
module accelerometer (
	clk,
	reset,
	address,
	byteenable,
	read,
	write,
	writedata,
	readdata,
	waitrequest,
	irq,
	I2C_SDAT,
	I2C_SCLK,
	G_SENSOR_CS_N,
	G_SENSOR_INT);	

	input		clk;
	input		reset;
	input		address;
	input		byteenable;
	input		read;
	input		write;
	input	[7:0]	writedata;
	output	[7:0]	readdata;
	output		waitrequest;
	output		irq;
	inout		I2C_SDAT;
	output		I2C_SCLK;
	output		G_SENSOR_CS_N;
	input		G_SENSOR_INT;
endmodule
