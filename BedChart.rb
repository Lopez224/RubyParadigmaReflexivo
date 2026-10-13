require 'tk' #(tk:libreria para generar el ambiente grafico)

#Función para generar graficos en forma de barras, y pide los parametros de camas para graficarlos
def openBedChart(totalBeds, publicBeds, privateBeds)

  #Inicializador y configuracion general de la ventana 
  graphWindow = TkToplevel.new do
    title "Gráfico de Distribución de Camas"
    geometry "#{WIDTH}x#{HEIGHT}"
  end

  #Texto de recibimiento (Titulos)
  Tk::Label.new(graphWindow) do
    text "Camas Públicas y Privadas (Total: #{totalBeds})"
    font "Arial 11 bold"
    pack('pady' => 15)
  end

  #Objeto tipo canvas que sirve como entorno graficador
  canvas = Tk::Canvas.new(graphWindow) do
    width 380
    height 150
    background "#f5f5f5"
    pack('pady' => 10)
  end

  #Definimos el ancho maximo que puede alcanzar el grafico
  maxWidth = (WIDTH-50)
  #Calculamos el porcentaje de camas públicas y privadas
  percentagePublic = publicBeds.to_f / totalBeds
  percentagePrivate = privateBeds.to_f / totalBeds

  #Definimos el ancho del grafico de las camas públicas y privadas
  publicwidth = maxWidth * percentagePublic
  privatewidth = maxWidth * percentagePrivate

  #Dibujamos el rectangulo que representa la cantidad de camas públicas
  canvas.create('text', 40, 30, 'text' => "Públicas (#{(percentagePublic * 100).round(1)}%): #{publicBeds}", 'anchor' => 'w', 'font' => 'Arial 9 bold')
  canvas.create('rectangle', 40, 45, 40 + maxWidth, 70, 'fill' => '#e0e0e0', 'outline' => '')
  canvas.create('rectangle', 40, 45, 40 + publicwidth, 70, 'fill' => '#008080', 'outline' => '')

  #Dibujamos el rectangulo que representa la cantidad de camas privadas
  canvas.create('text', 40, 90, 'text' => "Privadas (#{(percentagePrivate * 100).round(1)}%): #{privateBeds}", 'anchor' => 'w', 'font' => 'Arial 9 bold')
  canvas.create('rectangle', 40, 105, 40 + maxWidth, 130, 'fill' => '#e0e0e0', 'outline' => '')
  canvas.create('rectangle', 40, 105, 40 + privatewidth, 130, 'fill' => '#e59866', 'outline' => '')

  #Botón para cerrar la ventana de los graficos
  Tk::Button.new(graphWindow) do
    text "Cerrar Gráfico"
    command { graphWindow.destroy }
    pack('pady' => 15)
  end
end