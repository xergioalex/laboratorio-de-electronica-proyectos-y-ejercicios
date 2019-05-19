
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_TEST is
    Port ( clk : in  STD_LOGIC;
           rx : in  STD_LOGIC;
           tx : out  STD_LOGIC;
			  leds : out std_logic_vector (9 downto 0)
			 );
end UART_TEST;

architecture Behavioral of UART_TEST is
	component UART is
	port( clk: in std_logic;
		   data_i: in std_logic_vector (9 downto 0);
		   tx_ready: in std_logic;
		   rx: in std_logic;
		   rx_ready: out std_logic;
		   tx: out std_logic;
		   data_o: out std_logic_vector (9 downto 0));
	end component;
	
	signal data: std_logic_vector (9 downto 0) := (others =>'0'); 
	signal ready: std_logic := '0'; 
begin
	UART_COMPONENT: UART port map(clk, data,ready,rx,ready,tx,data);
	
	process(ready,data)
	begin
		if(rising_edge(ready)) then
			leds <= data;			
		end if;		
	end process;
	
	
end Behavioral;

