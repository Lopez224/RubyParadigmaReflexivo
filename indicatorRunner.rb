require_relative 'operations'

class IndicatorError < StandardError; end

def runIndicator(klass, values)
  # Introspección: ¿los datos que mandó la ventana coinciden con lo que la clase declara?
  missing = klass.parameters.keys - values.keys
  surplus = values.keys - klass.parameters.keys
  unless missing.empty? && surplus.empty?
    raise IndicatorError, "Parámetros inconsistentes (faltan: #{missing}, sobran: #{surplus})"
  end

  indicator = klass.new
  values.each { |name, value| indicator.public_send("#{name}=", value) }  # setters de attr_accessor (invocacion dinamica)
  indicator.calculate!
end