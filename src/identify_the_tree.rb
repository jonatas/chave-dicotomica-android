
require 'ruboto/activity'
require 'ruboto/widget'
require 'ruboto/menu'
require 'ruboto/util/toast'
require 'dicotomica'
ruboto_import_widgets :LinearLayout, :EditText, :TextView, :ListView, :Button
$activity.start_ruboto_activity "$dicotomica" do
  @dicotomica = Dicotomica.new
  def on_create(bundle)
    start_tree
  end
  def start_tree
      @node = @dicotomica
      go_to_list 
  end
  def go_to_list 
    items = @node.children.collect(&:name)
    setContentView(list_view :list => items, 
          :on_item_long_click_listener => proc{|av, v, pos, item_id| 
                @node = @node.children[pos]
                help_about
          },
          :on_item_click_listener => proc{|av, v, pos, item_id| 
                @node = @node.children[pos]
                if @node && @node.hasChildren?
                  go_to_list
                else

                  toast("Espécie encontrada")
                end
         }
    )
  end
 def about_us
    setContentView(Ruboto::R::layout::about)
    true
  end
 def help_about
    toast("Help about: #{@node.name}")
 end

  handle_create_options_menu do |menu|
    add_menu("Chave Dicotômica") { start_tree }
    add_menu("Sobre nós") { about_us }
    add_menu("Exit") {finish}
    true
  end
end

