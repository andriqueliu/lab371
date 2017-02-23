library verilog;
use verilog.vl_types.all;
entity dataCollectTop is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        data            : inout  vl_logic_vector(7 downto 0);
        startWrite      : in     vl_logic;
        startRead       : in     vl_logic;
        clkLight        : out    vl_logic;
        transferBit     : out    vl_logic;
        clkOut          : out    vl_logic;
        lights          : out    vl_logic_vector(7 downto 0);
        stateHEX        : out    vl_logic_vector(6 downto 0);
        pctgHEX         : out    vl_logic_vector(6 downto 0)
    );
end dataCollectTop;
