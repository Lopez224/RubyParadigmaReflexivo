#Bloque de importaciones
require 'tk'

#Método para inicializar y configurar la ventana de tasa epidemiológica
def openEpidemiologicalRateWindow
  epidemiologicalRateWindow = TkToplevel.new do
    title "Tasa Epidemiológica"
    geometry "#{WIDTH}x#{HEIGHT}"
  end

  root = TkRoot.new do
    background '#F5F7FA' 
    geometry "#{WIDTH}x#{HEIGHT}"
  end

  #Texto de bienvenida al módulo
  Tk::Label.new(epidemiologicalRateWindow) do
    text "¡Bienvenido al módulo para el calculo de Tasa Epidemiológica!"
    font 'Arial 10 bold'
    pack('pady' => 30)
  end

  #Marco contenedor del formulario de entrada de datos
  formFrame = Tk::Frame.new(epidemiologicalRateWindow) do
    pack('pady' => 15)
  end

  #Campo de texto y etiqueta para el total de eventos ocurridos
  Tk::Label.new(formFrame) { text "Total de eventos ocurridos:"; grid('row' => 0, 'column' => 0, 'padx' => 5, 'pady' => 10, 'sticky' => 'e') }
    fieldPastEvents = Tk::Entry.new(formFrame) do
    width 25
    grid('row' => 0, 'column' => 1, 'padx' => 10, 'pady' => 10, 'sticky' => 'w')
  end

  #Campo de texto y etiqueta para el total de la población
  Tk::Label.new(formFrame) { text "Total de la población:"; grid('row' => 1, 'column' => 0, 'padx' => 5, 'pady' => 10, 'sticky' => 'e') }
    fieldReferencePopulation = Tk::Entry.new(formFrame) do
    width 25
    grid('row' => 1, 'column' => 1, 'padx' => 10, 'pady' => 10, 'sticky' => 'w')
  end

  #Campo de texto y etiqueta para el periodo de tiempo en semanas
  Tk::Label.new(formFrame) { text "Periodo de tiempo (Semanas):"; grid('row' => 2, 'column' => 0, 'padx' => 5, 'pady' => 10, 'sticky' => 'e') }
    fieldTimePeriod = Tk::Entry.new(formFrame) do
    width 25
    grid('row' => 2, 'column' => 1, 'padx' => 10, 'pady' => 10, 'sticky' => 'w')
  end

  #Marco contenedor para la sección de resultados
  resultFrame = Tk::Frame.new(epidemiologicalRateWindow) do
    pack()
  end

  #Etiqueta descriptiva y campo de texto/resultado dinámico
  Tk::Label.new(resultFrame) { text "Resultado:"; grid('row' => 0, 'column' => 0, 'padx' => 5, 'pady' => 5, 'sticky' => 'e') }
    labelResult = Tk::Label.new(resultFrame) do
    text "--------------"
    grid('row' => 0, 'column' => 1, 'padx' => 5, 'pady' => 10, 'sticky' => 'w')
  end

  #Marco contenedor de los botones de acción
  buttonFrame = Tk::Frame.new(epidemiologicalRateWindow) do
    background '#F5F7FA' 
    pack('pady' => 10)
  end

  #Botón para validar los datos, realizar la verificación y mostrar el resultado o mensajes de error
  executeButton = Tk::Button.new(buttonFrame) do  
    background '#008C9E' 
    text "Mostrar resultado"
    grid('row' => 0, 'column' => 0, 'padx' => 5, 'pady' => 5)
    command {
    pastEvents = fieldPastEvents.value().strip()  
    referencePopulation = fieldReferencePopulation.value().strip()
    timePeriod = fieldTimePeriod.value().strip()

    if pastEvents.strip.empty? or referencePopulation.strip.empty? or timePeriod.strip.empty?
        labelResult.foreground = 'red'
        labelResult.text = "Por favor, ingrese todos los datos solicitados."
    else
      begin
        pastEvents = Integer(pastEvents)
        referencePopulation = Integer(referencePopulation)
        timePeriod = Integer(timePeriod)
        if !(pastEvents<0) and !(referencePopulation<0) and !(timePeriod<0)
          labelResult.foreground = 'green'
          labelResult.text =  runIndicator(EpidemiologicalRate, events: pastEvents, population: referencePopulation, weeks: timePeriod)
        else
          labelResult.foreground = 'red'
          labelResult.text = "Por favor, ingrese datos mayores o iguales que 0."
        end
      rescue ArgumentError
        labelResult.foreground = 'red'
        labelResult.text = "Por favor, ingrese datos numericos (Enteros)"
      end
    end}
  end

  #Botón para regresar o cerrar la ventana actual
  backButton = Tk::Button.new(buttonFrame) do
    background '#008C9E' 
    text "Regresar"
    grid('row' => 0, 'column' => 1, 'padx' => 5, 'pady' => 5)
    command { epidemiologicalRateWindow.destroy() }
  end
end