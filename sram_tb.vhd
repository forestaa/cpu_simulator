library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sram is
  port (
    XE1, E2A, XE3, XGA, XZCKE, ADVA, XLBO, ZZA, XWA, XFT : in std_logic;
    ZCLKMA : in std_logic_vector (1 downto 0);
    XZBE : in std_logic_vector (3 downto 0);
    ZA : in std_logic_vector (19 downto 0);
    ZD : inout std_logic_vector (31 downto 0));
--    ZDIN : in std_logic_vector(31 downto 0);
--    ZDOUT : out std_logic_vector(31 downto 0));
end sram;

architecture testbench of sram is
  type sram is array (0 to 1024) of std_logic_vector (31 downto 0);
  signal clk1 : std_logic;
  signal clk2 : std_logic;
  signal ram : sram := (others => (others => '0'));
  signal pipe1addr : std_logic_vector (19 downto 0) := x"00000";
  signal pipe2addr : std_logic_vector (19 downto 0) := x"00000";
  signal pipe1xwa : std_logic := '1';
  signal pipe2xwa : std_logic := '1';
begin
  clk1 <= ZCLKMA(0);
  clk2 <= ZCLKMA(1);
  process(clk1)
  begin
    if rising_edge(clk1) then
      pipe1xwa <= XWA;
--      pipe2xwa <= pipe1xwa;
      pipe1addr <= ZA;
--      pipe2addr <= pipe1addr;
      if pipe1xwa = '0' then
--        ram(conv_integer(pipe1addr)) <= ZDIN;
        ram(conv_integer(pipe1addr)) <= ZD;
      else
        ZD <= ram(conv_integer(pipe1addr));
--        ZDOUT <= ram(conv_integer(pipe1addr));
      end if;
    end if;
  end process;
end testbench;
        
