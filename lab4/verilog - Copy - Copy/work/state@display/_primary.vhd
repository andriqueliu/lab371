library verilog;
use verilog.vl_types.all;
entity stateDisplay is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        startScanning   : in     vl_logic;
        startTransfer   : in     vl_logic;
        address         : in     integer;
        HEX             : out    vl_logic_vector(6 downto 0)
    );
end stateDisplay;
