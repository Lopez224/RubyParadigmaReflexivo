module Indicators
  # Clase padre de los indicadores
  class Base  
    def self.registry
      @registry ||= [] # Lista de indicadores existentes 
    end 
    
    # Hook que Ruby ejecuta automáticamente cada vez que una clase hereda de Base
    def self.inherited(subclass) 
      registry << subclass
      super 
    end 

    # Declarar un dato de entrada
    def self.parameter(name, label) 
      @parameters ||= {}
      @parameters[name] = label
      attr_accessor name # Método de Ruby que genera de forma automática los getters y setters
    end 
    # Metodo para consultar lo declarado
    def self.parameters
      @parameters || {}  
    end

    # Metodo lector y escritor
    def self.title(val = nil)  
      @title = val if val 
      @title || name 
    end 
    
    # Metodo para que cada instancia hija sobrescriba 
    def calculate! 
      raise NotImplementedError, "Debe implementar el metodo #calcular en #{self.class}"
    end 
  end
end  




