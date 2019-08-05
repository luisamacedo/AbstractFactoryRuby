# A interface Abstract Factory declara um conjunto de métodos que retornam diferentes
# produtos abstratos. Estes produtos são chamados de família e estão relacionados por um
# tema ou conceito de alto nível. Os produtos de uma família geralmente são capazes de
# colaborar entre si. Uma família de produtos pode ter várias variantes,
# mas os produtos de uma variante são incompatíveis com produtos de outra.
class AbstractFactory
  def create_product_a
    raise NotImplementedError, "#{self.class} não implementou o método '#{__method__}'"
  end

  def create_product_b
    raise NotImplementedError, "#{self.class} não implementou o método '#{__method__}'"
  end
end

# Concrete Factories produzem uma família de produtos que pertencem a um único
# variante. A fábrica garante que os produtos resultantes sejam compatíveis. Nota
# que as assinaturas dos métodos da Concrete Factory devolvam um produto abstrato,
# enquanto dentro do método, um produto concreto é instanciado.
class ConcreteFactory1 < AbstractFactory
  def create_product_a
    ConcreteProductA1.new
  end

  def create_product_b
    ConcreteProductB1.new
  end
end
  
# Cada Concrete Factories tem uma variante de produto correspondente.
class ConcreteFactory2 < AbstractFactory
  def create_product_a
    ConcreteProductA2.new
  end

  def create_product_b
    ConcreteProductB2.new
  end
end

# Cada produto distinto de uma família de produtos deve ter uma interface base. Todos
# variantes do produto devem implementar essa interface.
class AbstractProductA
  def useful_function_a
    raise NotImplementedError, "#{self.class} não implementou o método '#{__method__}'"
  end
end

# Os produtos de concreto são criados pelas fábricas de concreto correspondentes.
class ConcreteProductA1 < AbstractProductA
  def useful_function_a
    'O resultado do produto A1.'
  end
end

class ConcreteProductA2 < AbstractProductA
  def useful_function_a
    'O resultado do produto A2.'
  end
end

# Aqui está a interface base de outro produto. Todos os produtos podem interagir
# uns com os outros, mas a interação adequada só é possível entre produtos de
# a mesma variante de concreto.
class AbstractProductB
  # O produto B é capaz de fazer sua própria coisa...
  def useful_function_b
    raise NotImplementedError, "#{self.class} não implementou o método'#{__method__}'"
  end

# ...mas também pode colaborar com os produtos.
#
# A Abstract Factory certifica-se de que todos os produtos que cria são do mesmo
# variante e, portanto, compatível.
  def another_useful_function_b(_collaborator)
    raise NotImplementedError, "#{self.class} não implementou o método '#{__method__}'"
  end
end

# Concrete Products are created by corresponding Concrete Factories.
class ConcreteProductB1 < AbstractProductB
  def useful_function_b
    'O resultado do produto B1.'
  end

# A variante, Produto B1, só funciona corretamente com a variante,
# Produto A1. No entanto, aceita qualquer instância do AbstractProductA como um
# argumento.
  def another_useful_function_b(collaborator)
    result = collaborator.useful_function_a
    "O resultado do B1 colaborando com o (#{result})"
  end
end

class ConcreteProductB2 < AbstractProductB
  def useful_function_b
    'O resultado do produto B2.'
  end

 # A variante, Produto B2, só é capaz de funcionar corretamente com a variante,
 # Produto A2. No entanto, aceita qualquer instância do AbstractProductA como um
 # argumento.
  def another_useful_function_b(collaborator)
    result = collaborator.useful_function_a
    "O resultado do B2 colaborando com o (#{result})"
  end
end

# O código do cliente trabalha com fábricas e produtos apenas por meio de tipos abstratos:
# AbstractFactory e AbstractProduct. Isso permite que você passe qualquer fábrica ou produto
# subclasse ao código do cliente sem quebrá-lo.
def client_code(factory)
  product_a = factory.create_product_a
  product_b = factory.create_product_b

  puts product_b.useful_function_b.to_s
  puts product_b.another_useful_function_b(product_a).to_s
end

# O código do cliente pode funcionar com qualquer classe de fábrica de concreto.
puts 'Cliente: Testando o código do cliente com o primeiro tipo de fábrica:'
client_code(ConcreteFactory1.new)

puts "\n"

puts 'Cliente: Testando o mesmo código de cliente com o segundo tipo de fábrica:'
client_code(ConcreteFactory2.new)
