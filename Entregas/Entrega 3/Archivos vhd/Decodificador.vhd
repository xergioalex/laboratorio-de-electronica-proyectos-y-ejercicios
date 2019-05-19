
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decodificador is
    Port ( pulso : in  STD_LOGIC;
           select_cont : out  STD_LOGIC;
           en_cont_1 : out  STD_LOGIC;
           en_cont_2 : out  STD_LOGIC);
end Decodificador;

architecture Behavioral of Decodificador is
	signal aux_select_cont : std_logic:='0';
begin
	process(pulso)
	begin
		if rising_edge(pulso) then
			aux_select_cont <= not aux_select_cont;
		end if;		
	end process;
	
	select_cont <= aux_select_cont;
	en_cont_1 <= '1' when aux_select_cont='0' else '0';
	en_cont_2 <= '1' when aux_select_cont='1' else '0';
	
end Behavioral;

