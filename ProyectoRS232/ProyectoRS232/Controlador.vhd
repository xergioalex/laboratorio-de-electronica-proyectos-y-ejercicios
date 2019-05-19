library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controlador is
    Port ( clk_Div_Freq : in  STD_LOGIC;
           Bit_Entrad : in  STD_LOGIC;
           Recepcion_Completa : in  STD_LOGIC;
           Transmision_Completa : in  STD_LOGIC;
           Habilitador_Recepcion : out  STD_LOGIC;
           Habilitador_Transferencia : out  STD_LOGIC);
end Controlador;

architecture Behavioral of Controlador is

begin

process(clk_Div_Freq)

 begin
  
  if Rising_edge(clk_Div_Freq) then	 
	 
	 if Bit_Entrad = '0' then
    Habilitador_Recepcion <= '1';
	 end if;

    if Recepcion_Completa = '1' then
	 Habilitador_Transferencia <= '1';
 	 Habilitador_Recepcion <= '0';
	 end if;

	 if Transmision_Completa = '1' then
    Habilitador_Transferencia <= '0';
    end if;
	  
  end if;

end process;

end Behavioral;

