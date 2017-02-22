	component nios2 is
		port (
			clk_clk                : in  std_logic                    := 'X';             -- clk
			hex0_export            : out std_logic_vector(6 downto 0);                    -- export
			hex1_export            : out std_logic_vector(6 downto 0);                    -- export
			hex2_export            : out std_logic_vector(6 downto 0);                    -- export
			hex3_export            : out std_logic_vector(6 downto 0);                    -- export
			hex4_export            : out std_logic_vector(6 downto 0);                    -- export
			hex5_export            : out std_logic_vector(6 downto 0);                    -- export
			keys_export            : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			leds_export            : out std_logic_vector(7 downto 0);                    -- export
			reset_reset_n          : in  std_logic                    := 'X';             -- reset_n
			switches_export        : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			readytotransfer_export : in  std_logic                    := 'X';             -- export
			transfer_export        : out std_logic;                                       -- export
			startscanning_export   : out std_logic;                                       -- export
			data_in_export         : in  std_logic_vector(7 downto 0) := (others => 'X')  -- export
		);
	end component nios2;

	u0 : component nios2
		port map (
			clk_clk                => CONNECTED_TO_clk_clk,                --             clk.clk
			hex0_export            => CONNECTED_TO_hex0_export,            --            hex0.export
			hex1_export            => CONNECTED_TO_hex1_export,            --            hex1.export
			hex2_export            => CONNECTED_TO_hex2_export,            --            hex2.export
			hex3_export            => CONNECTED_TO_hex3_export,            --            hex3.export
			hex4_export            => CONNECTED_TO_hex4_export,            --            hex4.export
			hex5_export            => CONNECTED_TO_hex5_export,            --            hex5.export
			keys_export            => CONNECTED_TO_keys_export,            --            keys.export
			leds_export            => CONNECTED_TO_leds_export,            --            leds.export
			reset_reset_n          => CONNECTED_TO_reset_reset_n,          --           reset.reset_n
			switches_export        => CONNECTED_TO_switches_export,        --        switches.export
			readytotransfer_export => CONNECTED_TO_readytotransfer_export, -- readytotransfer.export
			transfer_export        => CONNECTED_TO_transfer_export,        --        transfer.export
			startscanning_export   => CONNECTED_TO_startscanning_export,   --   startscanning.export
			data_in_export         => CONNECTED_TO_data_in_export          --         data_in.export
		);

