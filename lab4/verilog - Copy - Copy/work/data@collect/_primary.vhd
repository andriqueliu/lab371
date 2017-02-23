library verilog;
use verilog.vl_types.all;
entity dataCollect is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        data            : inout  vl_logic_vector(7 downto 0);
        address         : in     integer;
        out_en          : in     vl_logic;
        active          : in     vl_logic;
        RW              : in     vl_logic
    );
end dataCollect;
