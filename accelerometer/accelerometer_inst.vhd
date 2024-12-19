	component accelerometer is
		port (
			clk           : in    std_logic                    := 'X';             -- clk
			reset         : in    std_logic                    := 'X';             -- reset
			address       : in    std_logic                    := 'X';             -- address
			byteenable    : in    std_logic                    := 'X';             -- byteenable
			read          : in    std_logic                    := 'X';             -- read
			write         : in    std_logic                    := 'X';             -- write
			writedata     : in    std_logic_vector(7 downto 0) := (others => 'X'); -- writedata
			readdata      : out   std_logic_vector(7 downto 0);                    -- readdata
			waitrequest   : out   std_logic;                                       -- waitrequest
			irq           : out   std_logic;                                       -- irq
			I2C_SDAT      : inout std_logic                    := 'X';             -- I2C_SDAT
			I2C_SCLK      : out   std_logic;                                       -- I2C_SCLK
			G_SENSOR_CS_N : out   std_logic;                                       -- G_SENSOR_CS_N
			G_SENSOR_INT  : in    std_logic                    := 'X'              -- G_SENSOR_INT
		);
	end component accelerometer;

	u0 : component accelerometer
		port map (
			clk           => CONNECTED_TO_clk,           --                                 clk.clk
			reset         => CONNECTED_TO_reset,         --                               reset.reset
			address       => CONNECTED_TO_address,       -- avalon_accelerometer_spi_mode_slave.address
			byteenable    => CONNECTED_TO_byteenable,    --                                    .byteenable
			read          => CONNECTED_TO_read,          --                                    .read
			write         => CONNECTED_TO_write,         --                                    .write
			writedata     => CONNECTED_TO_writedata,     --                                    .writedata
			readdata      => CONNECTED_TO_readdata,      --                                    .readdata
			waitrequest   => CONNECTED_TO_waitrequest,   --                                    .waitrequest
			irq           => CONNECTED_TO_irq,           --                           interrupt.irq
			I2C_SDAT      => CONNECTED_TO_I2C_SDAT,      --                  external_interface.I2C_SDAT
			I2C_SCLK      => CONNECTED_TO_I2C_SCLK,      --                                    .I2C_SCLK
			G_SENSOR_CS_N => CONNECTED_TO_G_SENSOR_CS_N, --                                    .G_SENSOR_CS_N
			G_SENSOR_INT  => CONNECTED_TO_G_SENSOR_INT   --                                    .G_SENSOR_INT
		);

