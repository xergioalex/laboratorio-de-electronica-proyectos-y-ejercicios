library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Registros is	
	port( clk : in std_logic;
			add : in std_logic;
			sub : in std_logic;			
			out_cont : out std_logic_vector(7 downto 0)
		 );
end Registros; 

architecture arq_Registros of Registros is
	signal contador : std_logic_vector(7 downto 0) := (others => '0');
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if(add='1') then 
				if(contador="11111111") then
					contador <= "00000000";
				else
					contador <= contador+"00000001";
				end if;
			end if;
			if(sub='1') then 
				if(contador="0000000") then 
					contador <= "11111111";
				else
					contador <= contador-"00000001";
				end if;
			end if;
		end if;
	end process;
	
	out_cont <= contador;
	
end arq_Registros;