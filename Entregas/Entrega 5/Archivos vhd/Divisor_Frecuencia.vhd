library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Divisor_Frecuencia is
    Port ( clk : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
end Divisor_Frecuencia;

architecture Behavioral of Divisor_Frecuencia is
	signal contador : integer range 0 to 218:=0;-- defino la signal contador y la inicializo
	signal enable :  STD_LOGIC := '0';
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			contador <= contador+1;
			if(contador>=217)then
				enable <= not enable;
				contador <= 0;
			end if; 
		end if;
	end process;
	
	clk_out <= enable;
	 
end Behavioral;
