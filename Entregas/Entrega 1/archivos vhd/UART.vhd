
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UART is
port( clk: in std_logic;
		data_i: in std_logic_vector (9 downto 0);
		tx_ready: in std_logic;
		rx: in std_logic;
		rx_ready: out std_logic;
		tx: out std_logic;
		data_o: out std_logic_vector (9 downto 0));
		
end UART;

architecture arch_UART of UART is
	
	component FMS_RX is
	port( rx : in  STD_LOGIC;
         clkBaudio : in  STD_LOGIC;
         rx_ready : out  STD_LOGIC;
         data_o : out  STD_LOGIC_VECTOR (9 downto 0));
	end component;
	
	component FMS_TX is
   Port ( data_i : in  STD_LOGIC_VECTOR (9 downto 0);
          tx_ready : in  STD_LOGIC;
          clkBaudio : in  STD_LOGIC;
          tx : out  STD_LOGIC);
	end component;
	
	component Divisor_Frecuencia is
	Port ( clk : in  STD_LOGIC;
          clk_out : out  STD_LOGIC);
	end component;
	
	signal clkBaudio_out: std_logic := '0'; 
begin
	
	Divisor: Divisor_Frecuencia port map(clk, clkBaudio_out);
	RX_FMS: FMS_RX port map(rx, clkBaudio_out, rx_ready, data_o);
	TX_FMS: FMS_TX port map(data_i, tx_ready, clkBaudio_out, tx);

end arch_UART;

