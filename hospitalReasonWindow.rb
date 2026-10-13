#Bloque de importaciones
require 'tk'

#Método para inicializar y configurar la ventana de razón hospitalaria
def openHospitalReasonWindow
  hospitalReasonWindow = TkToplevel.new do
    title "Razón Hospitalaria"
    geometry "#{WIDTH}x#{HEIGHT}"
  end

  root = TkRoot.new do
    background '#F5F7FA' 
    geometry "#{WIDTH}x#{HEIGHT}"
  end

  #Texto de bienvenida al módulo
  Tk::Label.new(hospitalReasonWindow) do
    text "¡Bienvenido al módulo para el calculo de Razon Hospitalaria!"
    font 'Arial 10 bold'
    pack('pady' => 20)
  end

  #Marco contenedor del formulario de entrada de datos
  formFrame = Tk::Frame.new(hospitalReasonWindow) do
    pack('pady' => 15)
  end

    #Campo de texto y etiqueta para la población total
    Tk::Label.new(formFrame) { text "Población total:"; grid('row' => 0, 'column' => 0, 'padx' => 10, 'pady' => 10, 'sticky' => 'e') }
    fieldPopulation = Tk::Entry.new(formFrame) do
    width 25
    grid('row' => 0, 'column' => 1, 'padx' => 10, 'pady' => 10, 'sticky' => 'w')
  end

  #Campo de texto y etiqueta para el total de camas
  Tk::Label.new(formFrame) { text "Total de camas:"; grid('row' => 1, 'column' => 0, 'padx' => 10, 'pady' => 10, 'sticky' => 'e') }
    bedFields = Tk::Entry.new(formFrame) do
    width 25
    grid('row' => 1, 'column' => 1, 'padx' => 10, 'pady' => 10, 'sticky' => 'w')
  end

  #Marco contenedor para la sección de resultados
  resultFrame = Tk::Frame.new(hospitalReasonWindow) do
    pack()
  end

  #Etiqueta descriptiva y campo de texto/resultado dinámico
  Tk::Label.new(resultFrame) { text "Resultado:"; grid('row' => 0, 'column' => 0, 'padx' => 5, 'pady' => 5, 'sticky' => 'e') }
    labelResult = Tk::Label.new(resultFrame) do
    text "--------------"
    grid('row' => 0, 'column' => 1, 'padx' => 5, 'pady' => 10, 'sticky' => 'w')
  end

  #Marco contenedor de los botones de acción
  buttonFrame = Tk::Frame.new(hospitalReasonWindow) do
    background '#F5F7FA' 
    pack('pady' => 10)
  end

  #Botón para validar los datos, realizar la verificación y mostrar el resultado o mensajes de error
  executeButton = Tk::Button.new(buttonFrame) do   
    background '#008C9E' 
    text "Mostrar resultado"
    grid('row' => 0, 'column' => 0, 'padx' => 5, 'pady' => 5)
    command {
    totalPopulation = fieldPopulation.value().strip()  
    totalBeds = bedFields.value().strip()

    if totalPopulation.strip.empty? or totalBeds.strip.empty?
        labelResult.foreground = 'red'
        labelResult.text = "Por favor, ingrese todos los datos solicitados."
      else
        begin
          totalBeds = Integer(totalBeds)
          totalPopulation = Integer(totalPopulation)
          if !(totalPopulation<0) and !(totalBeds<0)
            labelResult.foreground = 'green'
            labelResult.text = runIndicator(HospitalBedRatio, num: totalBeds, denom: totalPopulation)
          else
            labelResult.foreground = 'red'
            labelResult.text = "Por favor, ingrese datos mayores o iguales que 0."
          end
        rescue ZeroDivisionError, IndicatorError => e
            labelResult.foreground = 'red'
            labelResult.text = e.message
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
    command { hospitalReasonWindow.destroy() }
  end
end