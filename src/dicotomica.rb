# encoding: utf-8
require "tree"
class Dicotomica < Tree::TreeNode
  attr_reader :last_node, :last_root
  def initialize name = "Chave Dicotômica", content = nil
    @pending_replace = {}
    super name,content

    CHAVES_ESTATICAS.split("\n").each do |instruction|
      know(instruction)
    end
    print_tree
  end

  CHAVE = /^CHAVE (.*) - (.*)/
  ITEM = /^(\d+)\.\s(.*)$/
  LINK = /\s\.{4}\s(\d+)$/
  SPECIE = /^\s{4}(.*)/
  
  def know(string)
    if string
      case string
      when CHAVE 
        add_root  [$1,$2].join(" - ")
      when ITEM
        if replace_node = @pending_replace[$1]
           @last_node = replace_node << Tree::TreeNode.new(string)
        else
           add_node string
        end
        if string =~ LINK
           @pending_replace[$1] = @last_node
        end
      when SPECIE
         add_specie $1
      end
    end
   end
   def add_root name
      @last_root = self << Tree::TreeNode.new(name, 'root')
   end
   def add_node name
      @last_node = @last_root << Tree::TreeNode.new(name, 'node')
   end
   def add_specie name
      @last_node << Tree::TreeNode.new(name, "specie")
   end
end
CHAVES_ESTATICAS = %{CHAVE 1 - PLANTAS DESPROVIDAS DE FOLHAS
1. Ramos suculentos, colunares, sucados longitudinalmente, com tufos de acúleos, sem espinhos terminais
    14.1 Cereus hildmannianus
1. Ramos não suculentos, comprimidos lateralmente, com espinho terminal, decussados, ocasionalmente de formato triangular
    61.1 Colletia paradoxa
CHAVE 2 - PALMEIRAS
1. Plantas com acúleos
    9.1 Acrocomia aculeata
1. Plantas sem acúleos .... 2
2. Lâminas em forma de leque, tão largas quanto compridas
    9.9 Trithrinax brasiliensis
2. Lâminas não em forma de leque, mais compridas que largas .... 3
3. Base dos pecíolos permanecendo ao longo do caule
    9.2 Butiaca pitata
    9.3 Butia eriospatha
    9.4 Butia yatay
3. Base dos pecíolos não permanecendo nos caules .... 4
4. Segmentos da folha dispostos em mais dois planos
    9.8 Syagros romanzoffiana
4. Segmentos da folha dispostos em dois planos .... 5
5. Base dos pecíolos de cor acinzentada
    9.5 Butyagros x nabuannandii
5. Base dos pecíolos de cor verde .... 6
6. Bainhas foliares envolvendo completamente a porção apical do caule
    9.6 Euterpe edulis
6. Bainhas foliares não envolvendo completamente a porção apical do caule
    9.7 Geonoma schottiana}
