
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM is
port( clk : in std_logic;
		ciclos : in std_logic_vector (15 downto 0);
		grado_servo : out std_logic
		);
end PWM;

architecture arch_PWM of PWM is
	signal contador : integer range 0 to 1000002 := 0;
	signal cont_aux1 : integer range 0 to 1000002 := 0;
	--signal carga : integer range 0 to 50000 := 50000;
begin		
	
	process(ciclos)
	begin
		cont_aux1 <= 50000 + CONV_INTEGER(ciclos);
	end process;
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(contador = 0) then			
				grado_servo <= '1';				
			elsif(contador = cont_aux1) then 
				grado_servo <= '0';
			end if;
			if(contador = 1000001) then
				contador <= 0;
			else
				contador <= contador + 1;
			end if;						
		end if;
	end process;
	
	

end arch_PWM;

