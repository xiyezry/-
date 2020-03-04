library verilog;
use verilog.vl_types.all;
entity data_memory is
    port(
        DMAdd           : in     vl_logic_vector(6 downto 0);
        DataIn          : in     vl_logic_vector(31 downto 0);
        DataOut         : out    vl_logic_vector(31 downto 0);
        DMW             : in     vl_logic;
        DMR             : in     vl_logic;
        clk             : in     vl_logic
    );
end data_memory;
