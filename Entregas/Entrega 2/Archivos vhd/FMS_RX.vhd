
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FMS_RX is
    Port ( rx : in  STD_LOGIC;
           clkBaudio : in  STD_LOGIC;
           rx_ready : out  STD_LOGIC:='0';
           data_o : out  STD_LOGIC_VECTOR (9 downto 0):=(others =>'0'));
end FMS_RX;

architecture arch_FMS_RX of FMS_RX is
	signal index : integer range 0 to 100;
	signal data_out_buffer : STD_LOGIC_VECTOR (9 downto 0):= (others=>'0');
	signal start : STD_LOGIC := '0';
begin
	process(clkBaudio)
	begin
		if(rising_edge(clkBaudio)) then
			if(start='0') then
				rx_ready <= '0';
			end if;
			if(index=0 and rx='0') then
				start <= '1';	
				data_out_buffer(9-index) <= rx;
				index<= index +1;
			end if;
			if(start='1') then
				data_out_buffer(9-index) <= rx;
				rx_ready <='0';
				index<= index +1;
			end if;
			if(index>=9) then
				rx_ready <= '1';
				start <= '0';
				index<=0;
			end if;		
		end if; 
	end process;
	 
	data_o <= data_out_buffer;
	
end arch_FMS_RX;

