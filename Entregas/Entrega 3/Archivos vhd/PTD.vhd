
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PTD is
	Port ( clk : in  STD_LOGIC;
          pulse : in  STD_LOGIC;
			 pulse_out : out STD_LOGIC 
			 );
end PTD;
	 
architecture Behavioral of PTD is
	signal salida : STD_LOGIC := '0';	
begin
	process(clk) begin
		if(rising_edge(clk)) then
			salida <= pulse;
		end if;
	end process;
		
	pulse_out <= pulse and not salida;
	
end Behavioral;