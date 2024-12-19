	accelerometer u0 (
		.clk           (<connected-to-clk>),           //                                 clk.clk
		.reset         (<connected-to-reset>),         //                               reset.reset
		.address       (<connected-to-address>),       // avalon_accelerometer_spi_mode_slave.address
		.byteenable    (<connected-to-byteenable>),    //                                    .byteenable
		.read          (<connected-to-read>),          //                                    .read
		.write         (<connected-to-write>),         //                                    .write
		.writedata     (<connected-to-writedata>),     //                                    .writedata
		.readdata      (<connected-to-readdata>),      //                                    .readdata
		.waitrequest   (<connected-to-waitrequest>),   //                                    .waitrequest
		.irq           (<connected-to-irq>),           //                           interrupt.irq
		.I2C_SDAT      (<connected-to-I2C_SDAT>),      //                  external_interface.I2C_SDAT
		.I2C_SCLK      (<connected-to-I2C_SCLK>),      //                                    .I2C_SCLK
		.G_SENSOR_CS_N (<connected-to-G_SENSOR_CS_N>), //                                    .G_SENSOR_CS_N
		.G_SENSOR_INT  (<connected-to-G_SENSOR_INT>)   //                                    .G_SENSOR_INT
	);

