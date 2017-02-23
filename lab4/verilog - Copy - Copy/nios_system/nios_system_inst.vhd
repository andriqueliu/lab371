	component nios_system is
		port (
			clk_clk           : in  std_logic                    := 'X';             -- clk
			reset_reset_n     : in  std_logic                    := 'X';             -- reset_n
			switches_export   : in  std_logic_vector(1 downto 0) := (others => 'X'); -- export
			gpio_0_out_export : out std_logic_vector(1 downto 0);                    -- export
			gpio_0_in_export  : in  std_logic                    := 'X'              -- export
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_clk           => CONNECTED_TO_clk_clk,           --        clk.clk
			reset_reset_n     => CONNECTED_TO_reset_reset_n,     --      reset.reset_n
			switches_export   => CONNECTED_TO_switches_export,   --   switches.export
			gpio_0_out_export => CONNECTED_TO_gpio_0_out_export, -- gpio_0_out.export
			gpio_0_in_export  => CONNECTED_TO_gpio_0_in_export   --  gpio_0_in.export
		);

