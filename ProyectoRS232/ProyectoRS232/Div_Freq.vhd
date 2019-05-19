library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Div_Freq is
    Port ( clk : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
end Div_Freq;

architecture Behavioral of Div_Freq is

signal cont : integer range 1 to 434;

begin

process(clk)
begin
 if Rising_edge (clk) then
  cont <= 1;
   if cont < 217 then
	 clk_out <= '0';
	 cont <= cont + 1;
	elsif cont >= 217 and cont < 434 then
    clk_out <= '1';
    cont <= cont + 1;
   elsif cont = 434 then
    clk_out <= '0';
    cont <= 1;
	 end if;
 end if;	
end process; 

end Behavioral;

