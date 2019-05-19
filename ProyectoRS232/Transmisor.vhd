library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Transmisor is
    Port ( clk_Div_Freq : in  STD_LOGIC;
           Habilitador_Transferencia : in  STD_LOGIC;
           Registro : in  STD_LOGIC_VECTOR (7 downto 0);
           Transferencia_Completa : out  STD_LOGIC;
           Bit_Salida : out  STD_LOGIC := '1');
end Transmisor;

architecture Behavioral of Transmisor is

signal cont : integer range 7 downto 0 := 7;
signal estado : integer range 1 to 3 := 1;

begin

process(clk_Div_Freq)

begin

 if Rising_edge(clk_Div_freq) then
  if Habilitador_Transferencia = '1' then

	if estado = 1 then

	 Bit_Salida <= '0';
	 Transferencia_Completa <= '0';
	 estado <= 2;
   end if;

	if estado = 2 then

	 if (cont >= 0 and cont <= 7) then
	  Bit_Salida <= Registro(cont);
	  cont <= cont - 1;
	  Transferencia_Completa <= '0';
	 end if;
	 if(cont = 0) then
	  Transferencia_Completa <= '1';
	  estado <= 3;
	 end if;
   end if;

	if estado = 3 then

	  Bit_Salida<='1';
	  cont <= 7;
	  Transferencia_Completa <= '0';
	  estado <= 1;
   end if;
  end if;
 end if;

end process;

end Behavioral;

