# encoding: utf-8
require "tree"
class Dicotomica < Tree::TreeNode
  attr_reader :last_node, :last_root
  def initialize name = "Chave Dicotômica", content = nil
    @pending_replace = {}
    super name,content

    CHAVE.split("\n").each do |instruction|
      know(instruction)
    end
  end

  def know(string)
    if string
      case string
      when /^CHAVE (.*) - (.*)/
        add_root  [$1,$2].join(" - ")
      when /^(\d+)\.\s(.*)$/
        if replace_node = @pending_replace[$1]
           @last_node = replace_node << Tree::TreeNode.new(string)
#           @pending_replace.delete $1
        else
           add_node string
        end
        if string =~ /\s\.\.\.\.\s(\d+)$/
           @pending_replace[$1] = @last_node
        end
      when /^\s{4}(.*)/
         add_specie $1
      end
    end
   end
   def add_root name
      @last_root = self << Tree::TreeNode.new(name, 'root')
   end
   def add_node name
      @last_node = @last_root << Tree::TreeNode.new(name, 'node')
   rescue
		 puts "ops!  erro adding a node #{$!}"
	   print_tree
   end
   def add_specie name
      @last_node << Tree::TreeNode.new(name, "specie")
   rescue
		 puts "ops!  erro adding a specie #{$!}"
	   print_tree
   end
end
CHAVE = %{CHAVE 1 - PLANTAS DESPROVIDAS DE FOLHAS
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
    9.7 Geonoma schottiana
CHAVE 3 - FOLHAS COMPOSTAS
1. Folhas digitadas ou trifolioladas .... 2
1. Folhas pinadas, bipinadas, ou tripinadas .... 22
2. Folhas digitadas .... 3
2. Folhas trifolioladas .... 13
3. Plantas latecentes; ramos com espinhos
    18.1 Jacaratia spinosa
3. Plantas não latecentes; ramos com ou sem acúleos .... 4
4. Folhas alternas .... 5
4. Folhas opostas .... 7
5. Folíolos com bordos recortados; ramos com acúleos
    39.2 Ceiba speciosa
5. Folíolos com bordos inteiros; ramos sem acúleos .... 6
6. Folíolos discolores
    7.4 Schefflera marototoni
6. Folíolos concolores
    39.6 Pseudobombax grandiflorus
7. Folíolos com bordos inteiros .... 8
7. Folíolos com bordos recortados .... 11
8. Folíolos pilosos, discolores
    11.6 Tabebuia pulcherrima
8. Folíolos concolores, glabros ou, se pilosos, nunca discolores .... 9
9. Pecíolos maiores que o comprimento do maior folíolo
    11.1 Cybistax antisyphilitica
9. Pecíolos menores que os folíolos .... 10
10. Folíolos com ápice acuminado, glabros
    32.4 Vitex megapotamica
10. Folíolos com ápice agudo ou obtuso, geralmente com tricomas mais ou menos esparsos pelo menos na face abaxial
    11.7 Tabebuia umbellata
11. Estípulas presentes, evidentes, arredondadas
    24.1 Lamanonia ternata
11. Estípulas ausentes ou de outras formas .... 12
12. Folíolos discolores, pilosos, brancos ou acinzentados na face abaxial
    11.4 Tabebuia alba
12. Folíolos concolores, glabros
    11.5 Tabebuia heptaphylla
13. Nervuras secundárias de coloração verde/amareladas evidente, mais clara que a lâmina, geralmente alcançando a margem dos folíolos, a maioria delas sem conectar-se umas as outras
    3.1 Lithraea brasiliensis
    3.2 Lithraea molleoides
13. Nervuras secundárias de tonalidade no máximo verde clara, sem contraste acentuado com a lâmina, formando arcos, geralmente conectando-se umas as outras, se alcançar a margem dos folíolos .... 14
14. Folhas alternas .... 15
14. Folhas opostas. Lâmina com glândulas translúcidas .... 20
15. Folíolos inteiros .... 16
15. Folíolos recortados .... 18
16. Peciólulos de base não entumecida ou ausente; margem dos folíolos ondulada
    41.7 Trichilia claussenii
16. Peciólulos de base entumecida; margem dos folíolos não ondulada .... 17
17. Ramos com acúleos
    31.16 Erythrina falcata
17. Ramos sem acúleos
    31.15 Erythrina cristagalli
18. Folíolo central até 50 mm de comprimento, frequentemente pilosos embaixo
    68.2 Allophylus guaraniticus
18. Folíolo central com mais de 50 mm de comprimento .... 19
19. Folíolos pilosos em ambas as faces
    68.3 Allophylus puberulus
19. Folíolos glabros, no máximo com tufos de tricomas nas domácias
    68.1 Allophylus edulis
20. Folíolos com mais de 20 mm de largura, geralmente com domácias
    64.1 Balfourodendron riendelianum
20. Folíolos com até 20 mm de largura, geralmente sem domácias .... 21
21. Folíolo central apículado; floresta Alto Uruguai e Serra do Sudeste
    64.4 Helietta apiculata
21. Folíolo central não apículado; floresta atlântica
    64.3 Esenbeckia hieronymii
22. Folhas tripinadas
    7.1 Aralia warmingiana
22. Folhas pinadas ou bipinadas .... 23
23. Folhas opostas .... 24
23. Folhas alternas .... 29
24. Raque não alada .... 25
24. Raque alada .... 27
25. Folíolos com mais de 40 mm de comprimento
    2.1 Sambucus australis
25. Folíolos com menos de 30 mm de comprimento .... 26
26. Folíolos de bordos inteiros
    11.2 Jacaranda micrantha
26. Folíolos de bordos recortados
    11.3 Jacaranda puberula
27. Folíolo terminal com menos de 20 mm de comprimento ( cerca de 10 mm)
    24.3 Weinmannia hunilis
27. Folíolo terminal com mais de 20 mm de comprimento .... 28
28. Folhas com 5 a 7 folíolos
    24.2 Weinmannia discolor
28. Folhas com 9 ou mais folíolos
    24.4 Weinmannia paulliniifolia
29. Folíolos com glândulas translúcidas na lâmina .... 30
29. Folíolos sem glândulas translúcidas na lâmina .... 35
30. Folíolos com bordo recortado; glândulas as vezes visíveis somente na margem, junto aos dentes; plantas geralmente com espinhos .... 31
30. Folíolos com bordo inteiro; plantas sem espinhos .... 34
31. Folhas com mais de quinze folíolos, estes com menos de 5 mm de largura
    64.9 Zanthoxylum kleinii
31. Folhas com dez folíolos ou menos, estes com mais de 5 mm de largura .... 32
32. Ramos e folhas novas com tricomas dentriticos esparsos
    64.6 Zanthoxylum astrigerum
32. Ramos e folhas novas sem tricomas ou com tricomas simples, não dentríticos .... 33
33. Folíolos oblongos
    64.7 Zanthoxylum caribaeum
33. Folíolos elípticos ou lanceolados
    64.8 Zanthoxylum fagara
    64.11 Zanthoxylum rhoifolium
34. Folíolos oblongos, geralmente opostos, exceto o terminal
    64.5 Pilocarpus pennatifolius
34. Folíolos elípticos ou ovados, geralmente alternos
    31.38 Myrocarpus frondosus
35. Folhas pinadas .... 36
35. Folhas bipinadas .... 100
36. Folhas paripinadas .... 37
36. Folhas imparipinadas .... 49
37. Raque alada .... 38
37. Raque não alada .... 42
38. Folíolos de bordos recortados
    3.4 Schinus lentiscifolius
38. Folíolos de bordos inteiros .... 39
39. Folhas pilosas .... 40
39. Folhas glabras .... 41
40. Raque com mais de 20 cm de comprimento
    31.21 Inga sessilis
40. Raque com menos de 20 cm de comprimento
    31.22 Inga striata
    31.23 Inga vera
    31.24 Inga virenscens
41. Folíolos basais maiores de 30 mm de comprimento
    31.20 Inga marginata
41. Folíolos basais menores de 30 mm de comprimento
    31.19 Inga lentiscifolia
42. Folhas com glândulas salientes no pecíolo e/ou entre os folíolos .... 43
42. Plantas sem glândulas salientes no pecíolo e/ou entre os folíolos .... 45
43. Glândulas salientes na base do pecíolo e as vezes também entre os pares distais de folíolos
    31.48 Senna oblongifolia
43. Glândulas salientes somente entre os primeiros pares de folíolos .... 44
44. Folhas com 2-3 (-4) folíolos, estes geralmente ovais a lanceolados
    31.47 Senna corymbosa
44. Folhas com 4-6 folíolos, estes geralmente obovados a oblanceolados
    31.49 Senna pendula
45. Folíolos geramente menos de 10, obovados ou elípticos .... 46  
45. Folíolos mais de 10, oblongos ou lanceolados, se menos de 10, com a largura menor que a metade do comprimento; ápice da raque sem projeção .... 47
46. Folíolos com largura igual a mais da metade do comprimento; ápice da raque com projeção capituliforme; frequentemente a raque e a projeção apical tem indumento suave mas evidente
    41.4 Guarea macrophylla
46. Folíolos com largura geralmente menor que a metade do comprimento; ápice da raque com projeção acircular; raque sempre glabra
    68.9 Matayba guianensis
47. Folhas com redes de nervuras terciárias laxa: ramos novos glábros
    41.1 Cabralea canjerana
47. Folhas com redes de nervuras terciárias densa .... 48
48. Ramos novos glabros
    64.10 Zanthoxylum petiolare
48. Ramos novos pilosos
    41.2 Cedrela fissilis
49. Raque alada ou marcadamente achatada, pelo menos na metade distal de cada segmento .... 50
49. Raque não alada .... 54
50. Raque achatada .... 51
50. Raque alada .... 52
51. Folíolos até 20 mm de largura
    68.7 Matayba cristae
51. Folíolos com mais de 20 mm de largura
    68.10 Matayba juglandifolia
52. Nervuras secundárias divergindo da central em ângulo maior que 60 graus ( até 90 graus) .... 53
52.  Nervuras secundárias divergindo da central em ângulo inferior a 60 graus (cerca de 30 graus)
    3.4 Schinus lentiscifolius
53. Folhas com mais de sete folíolos, o terminal de tamanho mais ou menos semelhante aos outros folíolos
    3.8 Schinus terebinthifolius
53. Folhas com até sete folíolos, o terminal em geral visivelmente maior que os demais
    3.6 Schinus pearcei
54. Folhas com até treze folíolos .... 55
54. Folhas com mais de quinze folíolos .... 91
55. Folíolos, exceto o terminal, opostos .... 56
55. Folíolos alternos .... 71
56. Folíolos recortados .... 57
56. Folíolos inteiros .... 61
57. Glândulas translúscidas na lâmina, especialmente junto aos dentes
    64.11 Zanthoxylum rhoifolium
57. Sem glândulas na lâmina .... 58
58. Folíolos lanceolados; folhas geralmente pêndulas dos ramos .... 59
58. Folíolos obovados ou elípticos, nunca lanceolados; ápice dos folíolos obtuso ou agúdo, nunca apículado; folhas não pêndulas dos ramos .... 60
59. Folíolos com ápice apiculado; peciólulos acima de 3 mm de comprimento
    3.1 Myracrodruon balansae
59. Folíolos com ápice longo-acuminado, raro um pouco apiculado; folíolos sésseis
    3.5 Schinus molle
60. Ramos novos com tricomas castanho-avermelhados
    59.1 Euplassa nebularis
60. Ramos novos glabros
    70.2 Picrasma crenata
61. Nervuras secundárias sem formar arcos, dirigindo-se diretamente a margem da folha
    3.2 Lithraea molleoides
61. Nervuras secundárias formando arcos as adjacentes, sem seguir a margem das lâminas .... 62
62. Ramos com intumescimento irregularmente arredondado diretamente na junção com o pecíolo
    13.1 Protiu kleinii
62. Ramos sem intumescimento como o descrito na junção com o pecíolo .... 63
63. Folhas, pelo menos as novas, com tricomas lepidotos
    41.9 Trichilia lepidota
63. Folhas sem tricomas lepidotos, se pilosos com outros tipos de tricomas .... 64
64. Folíolos com mais de 100 mm de comprimento
    41.10 Trichilia pallens
64. Folíolos de dimensões menores .... 65
65. Folíolos com domácias .... 66
65. Folíolos sem domácias .... 67
66. Folíolo terminal com até 50 mm de comprimento, geralmente menos
    41.8 Trichilia elegans
66. Folíolo terminal com 50 mm de comprimento ou mais
    41.5 Trichilia casarettoi
67. Folíolos ovados, longo-acuminados .... 68
67. Folíolos elípticos, obovados ou oblongos, acuminados ou não .... 69
68. Folhas com cinco folíolos
    31.11 Dahlstedtia pentaphylla
68. Folhas com sete folíolos
    31.12 Dahlstedtia pinnata
69. Folhas com menos de 30 mm de largura
    31.25 Lonchocarpus campestris
    31.26 Lonchocarpus cultratus
    31.28 Lonchocarpus nitidus
    31.29 Lonchocarpus torrensis
69. Folíolos com mais de 30 mm de largura .... 70
70. Plantas da floresta estacional do Alto Uruguai
    31.27 Lonchocarpus muehlbergianus
70. Plantas da floresta atlântica
    31.39 Ormosia arborea
71. Folíolos recortados .... 72
71. Folíolos inteiros .... 76
72. Folíolos com largura inferior a 20 mm .... 73
72. Folíolos com largura superior a 20 mm .... 75
73. Indumento, pelo menos nos ramos, acinzentado
    68.5 Diatenopteryx sorbifolia
73. Indumento, pelo menos nos ramos, castanho-avermelhado .... 74
74. Ramos apresentando, além das folhas compostas, algumas simples
    59.3 Roupala brasiliensis
74. Ramos com todas as folhas compostas
     59.2 Roupala asplenioides
75. Folíolos com até cinco pares de dentes; região de mata nebular e encosta da mata atlântica
    59.1 Euplassa nebularis
75. Folíolos com mais de cinco pares de dentes; todas as regiões do Estado
    68.4 Cupania vernalis
76. Folíolos com domácias .... 77
76. Folíolos sem domácias .... 79
77. Folíolos elípticos ou lanceolados
    68.8 Matayba eleagnoides
77. Folíolos obovados .... 78
78. Folíolo terminal com até 50 mm de comprimento, geralmente menos
    41.8 Trichilia elegans
78. Folíolo terminal com 50 mm de comprimento ou mais
    41.5 Trichilia casarettoi
79. Folíolos basais arredondados e marcadamente diferentes dos demais folíolos; todos os folíolos fortemente assimétricos em relação a nervura central .... 80
79. Folíolos basais não ou raramente arredondados, semelhantes aos demais folíolos; folíolos pouco ou não assimétricos em relação a nervura central .... 83
80. Folíolo terminal com mais de 20 mm de largura .... 81
80. Folíolo terminal com menos de 20 mm de largura; folíolos pilosos ou não, mas o indumento neste caso só é visível sob aumento e/ou sensível ao tato .... 82
81. Folíolos obovados, geralmente pilosos
    55.2 Picramnia sellowii
81. Folíolos ovados, sempre glabros
    31.44 Poecilanthe parviflora
82. Base dos folíolos aguda
    41.6 Trichilia catigua
82. Base dos folíolos obtusa
    55.1 Picramnia parvifolia
83. Folhas com 11-13 folíolos oblongos, a relação comprimento/largura acima de 3:1
    31.33 Machaerium stipitatum
83. Folhas com 5-9 (raro 11) folíolos lanceolados, ovados ou obovados, a relação comprimento/largura cerca de 3:1, ocasionalmente menor .... 84
84. Raque com uma projeção apical, as vezes capituliforme, as vezes acircular, ou então o folíolo terminal com pelo menos uma estípula linear, 1-2 mm de comprimento por 0,1-0,2 mm de largura .... 87
84. Raque com projeção apical .... 85
85. Folíolos com ápice longo-acuminado, não apículados
    31.32 Machaerium paraguariense
85. Folíolos com ápice agudo, obtuso ou emarginado, eventualmente apiculados .... 86
86. Arcos das nervuras secundárias distantes em torno de 1 mm da margem da folha
    31.5 Apudeia leiocarpa
86. Arcos das nervuras secundárias distantes no máximo 0,5 mm (geralmente 0,2-0,3 mm) da margem da folha}
