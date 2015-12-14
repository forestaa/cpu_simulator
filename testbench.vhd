LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;

entity SIKI_testbench is
end SIKI_testbench;

architecture testbench of SIKI_testbench is
  component siki
    port(
      clk    : in std_logic;
      RS_RX  : in std_logic;
      XE1    : out std_logic;
      E2A    : out std_logic;
      XE3    : out std_logic;
      XGA    : out std_logic;
      XZCKE  : out std_logic;
      ADVA   : out std_logic;
      XLBO   : out std_logic;
      ZZA    : out std_logic;
      ZCLKMA : out std_logic_vector(1 downto 0);
      ZD     : inout std_logic_vector(31 downto 0);
--      ZDIN   : in std_logic_vector(31 downto 0);
--      ZDOUT  : out std_logic_vector(31 downto 0);
      XWA    : out std_logic;
      XFT    : out std_logic;
      XZBE   : out std_logic_vector(3 downto 0);
      ZA     : out std_logic_vector(19 downto 0);
      RS_TX  : out std_logic);
  end component;

  component tx
    generic(
      wtime : std_logic_vector(15 downto 0) := x"0003");
    port(
      clk    : in std_logic;
      go     : in std_logic;
      input  : in std_logic_vector(7 downto 0);
      busy   : out std_logic;
      sent   : out std_logic;
      output : out std_logic);
  end component;

  component sram
    port (
      XE1, E2A, XE3, XGA, XZCKE, ADVA, XLBO, ZZA, XWA, XFT : in std_logic;
      ZCLKMA : in std_logic_vector (1 downto 0);
      XZBE : in std_logic_vector (3 downto 0);
      ZA : in std_logic_vector (19 downto 0);
      ZD : inout std_logic_vector (31 downto 0));
--      ZDIN : in std_logic_vector(31 downto 0);
--      ZDOUT : out std_logic_vector(31 downto 0));
  end component;

  type table is array(0 to 12) of std_logic_vector(31 downto 0);
  constant testtable : table := (
   x"7000003f", x"00000000", x"36940001", x"2002000b", x"2004002b",
   x"0000000c", x"2004002c", x"0000000c", x"0000000c", x"2002000c",
   x"0000000c", x"ffffffff", x"00002223");
  signal simclk : std_logic := '0';
  signal count : std_logic_vector (4 downto 0) := "00000";
  signal instr : std_logic_vector (31 downto 0);
  signal shift_instr : std_logic_vector (31 downto 0);
  signal send_instr : std_logic_vector (7 downto 0);
  signal addr : std_logic_vector(7 downto 0) := "00000000";
  signal output : std_logic;
  signal tx_busy : std_logic;
  signal tx_go : std_logic;
  signal tx_sent : std_logic;
  signal tx2core : std_logic;
  signal xe1 : std_logic;
  signal e2a : std_logic;
  signal xe3 : std_logic;
  signal xga : std_logic;
  signal xzcke : std_logic;
  signal adva : std_logic;
  signal xlbo : std_logic;
  signal zza : std_logic;
  signal zclkma : std_logic_vector (1 downto 0);
  signal zd : std_logic_vector (31 downto 0) := x"00000000";
--  signal zd_cpu2sram : std_logic_vector(31 downto 0);
--  signal zd_sram2cpu : std_logic_vector(31 downto 0);
  signal xwa : std_logic;
  signal xft : std_logic;
  signal xzbe : std_logic_vector (3 downto 0);
  signal za : std_logic_vector (19 downto 0);
begin
  instr <= testtable(conv_integer(addr));
  send_instr <= shift_instr(7 downto 0);
  process(simclk)
  begin
    if rising_edge(simclk) then
      if tx_busy = '0' and count /= 6 then
        tx_go <= '1';
      else
        tx_go <= '0';
      end if;
      case count is
        when "00000" =>
          if tx_go = '1' then
            count <= count + 1;
            shift_instr <= "00000000" & shift_instr (31 downto 8);
          else
            shift_instr <= instr;
          end if;
        when "00011" =>
          if tx_go = '1' then
            if addr /= 11 then
              count <= "00000";
              addr <= addr + 1;
            else
              count <= "00100";
              addr <= addr + 1;
            end if;
          end if;
        when "00100" =>
          if tx_go = '1' then
            count <= "00110";
            shift_instr <= "00000000" & shift_instr (31 downto 8);
          else
            shift_instr <= instr;
          end if;
        when "00101" =>
          if tx_go = '1' then
            count <= "00110";
          end if;
        when "00110" =>
          null;
        when others =>
          if tx_go = '1' then
            shift_instr <= "00000000" & shift_instr (31 downto 8);
            count <= count + 1;
          end if;
      end case;
    end if;
  end process;
  
  clockgen : process
  begin
    simclk <= '0';
    wait for 5 ns;
    simclk <= '1';
    wait for 5 ns;
  end process;
  
  load_instr: tx
    generic map(
      wtime => x"0003")
    port map(
      clk => simclk,
      go => tx_go,
      input => send_instr,
      busy => tx_busy,
      sent => tx_sent,
      output => tx2core);
  memory: sram
    port map(
      XE1 => xe1,
      E2A => e2a,
      XE3 => xe3,
      XGA => xga,
      XZCKE => xzcke,
      ADVA => adva,
      XLBO => xlbo,
      ZZA => zza,
      ZCLKMA => zclkma,
      ZD => zd,
--      ZDIN => zd_cpu2sram,
--      ZDOUT => zd_sram2cpu,
      XWA => xwa,
      XFT => xft,
      XZBE => xzbe,
      ZA => za);
  core: siki
    port map(
      clk => simclk,
      RS_RX => tx2core,
      XE1 => xe1,
      E2A => e2a,
      XE3 => xe3,
      XGA => xga,
      XZCKE => xzcke,
      ADVA => adva,
      XLBO => xlbo,
      ZZA => zza,
      ZCLKMA => zclkma,
      ZD => zd,
--      ZDIN => zd_sram2cpu,
--      ZDOUT => zd_cpu2sram,
      XWA => xwa,
      XFT => xft,
      XZBE => xzbe,
      ZA => za,
      RS_TX => output);
end testbench;
