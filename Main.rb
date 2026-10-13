#Bloque de importaciones 
require 'tk' #(tk:libreria para generar el ambiente grafico)
require_relative 'hospitalReasonWindow'
require_relative 'bedRatioWindow'
require_relative 'oddsWindow'
require_relative 'epidemiologicalRateWindow' 
require_relative 'operations' 

#Constantes WIDTH Y HEIGHT (ANCHO Y LARGO) que definen el tamaño de las ventanas
WIDTH = 500 
HEIGHT = 400

#Inicializador y configuracion general de la ventana 
root = TkRoot.new do
  background '#F5F7FA' 
  title "MINSALUD APP"
  geometry "#{WIDTH}x#{HEIGHT}"
end

#Texto de bienvenida
welcomeLabel = Tk::Label.new(root) do
  background '#F5F7FA' 
  font 'Arial 10 bold'
  text "Bienvenid@ al sistema de calculos del MINSALUD\nescoja la operacion que desea ejecutar en la APP"
  pack( 'pady' => 30 , 'ipady' => 30)
end

#Marco contenedor de los botones (Botonera)
buttonFrame = Tk::Frame.new(root) do
  background '#F5F7FA' 
  pack()
end
MODULES = {
  "Razón Hospitalaria"  => :openHospitalReasonWindow,
  "Proporción de Camas" => :openBedRatioWindow,
  "Odds (Momios)"       => :openOddsWindow,
  "Tasa Epidemiológica" => :openEpidemiologicalRateWindow
}
mainContext = self 
MODULES.each_with_index do |(etiqueta, accion), i|
  Tk::Button.new(buttonFrame) do
    background '#008C9E'
    text etiqueta
    grid('row' => i / 2, 'column' => i % 2, 'padx' => 5, 'pady' => 5)
    command {
      if mainContext.respond_to?(accion, true)   # introspección
        mainContext.send(accion)                 # invocación dinámica
      else
        Tk.messageBox('type' => 'ok', 'icon' => 'error', 'title' => 'Error',
                      'message' => "No existe el módulo #{accion}")
      end
    }
  end
end
#Loop que mantiene abierto el menú principal para que no se cierre (No borrar)
Tk.mainloop