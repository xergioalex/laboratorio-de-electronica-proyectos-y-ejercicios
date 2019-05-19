library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FMS_TX is
    Port ( data_i : in  STD_LOGIC_VECTOR (9 downto 0);
           tx_ready : in  STD_LOGIC;
           clkBaudio : in  STD_LOGIC;
           tx : out  STD_LOGIC := '1');
end FMS_TX;

architecture arch_FMS_TX of FMS_TX is
	signal index: integer range 0 to 20 := 9;
	signal start : STD_LOGIC := '0';
begin
	process(tx_ready, clkBaudio)
	begin
		if(rising_edge(clkBaudio))then	
			if(tx_ready = '1' and index=9) then				
				start <= '1';
			end if;
			if(start='1') then
				tx <= data_i(index);										
				index <= index-1;
			end if;
			if(index<=0) then
				start<='0';
				index<=9;
			end if;						
		end if;
	end process;
end arch_FMS_TX;

