package pserial;

/* Interfaz de envio de daos a Servomotor
By  Cristian Steven Chavarro Rico
	Sergio Alexander Florez Galeano
	
	Descripcion: Software capas de realizar una conexion con un puerto serial y enviar y recivir datos a traves de este*/
	

//Importacion de Librerias de JAVA que se utilizaran
import java.util.List;
import java.util.Random;

//Importe de Librearias de Giovynet para el manejo de pueto serial.
import giovynet.serial.*;
import giovynet.nativelink.*;

public class Serial {
	
	//Lista que contiene los puerts libres, Creacion del pueto serial y una variable aleatoria
	List<String> freePorts;
	SerialPort serialPort = new SerialPort();
	Random rnd = new Random();
	
	public Serial(){
		System.out.println("Welcome");
	}
	
	//Esta función revisa que puertos estan disponibles, si no hay retorna TRUE
	public boolean revisarPuerto() throws Exception{
		freePorts = serialPort.getFreeSerialPort();
		return freePorts.isEmpty();
	}
	
	//Función que retorna los puertos libres
	public List<String> getFreePorts() {
		return freePorts;
	}
	
	//Determina los parametros que va a tener el puerto ( baudios, puerto, tardanzas, etc)
	private Parameters gerenarParametros(String com) throws Exception {
		Parameters param = new Parameters();
		//Asigna los parametros por defecto
		param.setPort(com);
		param.setMinDelayRead(10);
		param.setMinDelayWrite(10);
		param.setBaudRate(Baud._115200);
		return param;
	}
	
	//Intancia o crea el puerto a usar con sus respecivos parametros
	private Com crearPuerto(Parameters parametros) throws Exception {
		Com com = new Com(parametros);
		return com;
	}

	//envia una cantidad determinada de datos aleatorios
	private void enviaDato(Com puerto) throws Exception {
		int dato;
		System.out.print("Datos a enviar: ");
		for(int i = 1; i <= 512; i++){
			//Genera el numero aleatorio y lo convierte en char
			dato = rnd.nextInt(255) ;
			System.out.print(dato + " ");
			puerto.sendSingleData(dato);
		}
	}
	
	//Recive el dato que se envia al puerto
	private void recivirDato(Com puerto) throws Exception {
		System.out.print("\nLos datos recividos: ");
		int rcv;
		int i = 0;
		while(i < 512){
			rcv = puerto.receiveSingleDataInt();
			System.out.print(rcv + " ");
			i++;
		}
	}
	
	//Funcion principal
	public static void main(String[] args) throws Exception {
		Serial UART = new Serial();
		//Crea los parametros y el puerto
		Parameters parametros;
		Com puerto1;
		Com puerto3;
		
		if(!UART.revisarPuerto()){
			System.out.println("Los Puertos Abiertos: " + UART.getFreePorts());
			
			//Envia el primer puerto, en este caso COM1
			parametros = UART.gerenarParametros(UART.freePorts.get(0));
			puerto1 = UART.crearPuerto(parametros);
			
			//parametros = UART.gerenarParametros(UART.freePorts.get(1));
			//puerto3 = UART.crearPuerto(parametros);
			
			//Enviar Datos
			UART.enviaDato(puerto1);
			
			//Resivir Datos
			//UART.recivirDato(puerto3);
			
			//Close Port
			UART.serialPort.closePortC("COM1");
			//UART.serialPort.closePortC("COM3");
		}
		else
			System.out.println("No Puertos Libres");
	}


}