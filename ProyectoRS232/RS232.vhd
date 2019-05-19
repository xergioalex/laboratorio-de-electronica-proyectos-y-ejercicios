library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RS232 is
    Port ( clk_fpga : in  STD_LOGIC;
           Bit_Entrada : in  STD_LOGIC;
           Bit_Salida : out  STD_LOGIC);
end RS232;

architecture Behavioral of RS232 is

	COMPONENT Div_Freq
	PORT(
		clk : IN std_logic;          
		clk_out : OUT std_logic
		);
	END COMPONENT;

	COMPONENT Controlador
	PORT(
		clk_Div_Freq : IN std_logic;
		Bit_Entrad : IN std_logic;
		Recepcion_Completa : IN std_logic;
		Transmision_Completa : IN std_logic;          
    	Habilitador_Recepcion : OUT std_logic;
		Habilitador_Transferencia : OUT std_logic
		);
	END COMPONENT;

	COMPONENT Receptor
	PORT(
		clk_Div_Freq : IN std_logic;
		Bit_Entrada : IN std_logic;
		Habilitador_Recepcion : IN std_logic;          
		Recepcion_completa : OUT std_logic;
		Registro : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	COMPONENT Transmisor
	PORT(
		clk_Div_Freq : IN std_logic;
		Habilitador_Transferencia : IN std_logic;
		Registro : IN std_logic_vector(7 downto 0);
		Transferencia_Completa : OUT std_logic;
		Bit_Salida : OUT std_logic
		);
	END COMPONENT;

signal C_clk_Div_Freq, CC_Recepcion_Completa, CC_Transmision_Completa, CC_Habilitador_Recepcion, CC_Habilitador_Transferencia : std_logic; 	
signal C_Registro : std_logic_vector(7 downto 0);


begin

	Inst_Div_Freq: Div_Freq PORT MAP(
		clk => clk_fpga,
		clk_out => C_clk_Div_Freq
	);

	Inst_Controlador: Controlador PORT MAP(
		clk_Div_Freq =>  C_clk_Div_Freq,
		Bit_Entrad => Bit_Entrada,
		Recepcion_Completa => CC_Recepcion_Completa,
		Transmision_Completa => CC_Transmision_Completa,
    	Habilitador_Recepcion => CC_Habilitador_Recepcion,
		Habilitador_Transferencia => CC_Habilitador_Transferencia
	);

	Inst_Receptor: Receptor PORT MAP(
		clk_Div_Freq =>  C_clk_Div_Freq,
		Bit_Entrada => Bit_Entrada,
		Habilitador_Recepcion => CC_Habilitador_Recepcion,
		Recepcion_completa => CC_Recepcion_Completa,
		Registro => C_Registro
	);

	Inst_Transmisor: Transmisor PORT MAP(
		clk_Div_Freq =>  C_clk_Div_Freq,
		Habilitador_Transferencia => CC_Habilitador_Transferencia,
		Registro => C_Registro,
		Transferencia_Completa => CC_Transmision_Completa,
		Bit_Salida => Bit_Salida
	);


end Behavioral;

