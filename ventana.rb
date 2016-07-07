#!/usr/bin/ruby
#requerimos la librería gtk2
#depende de ruby1.8+ - ruby-gnome2 - ruby-gnome-dev
require 'gtk2'
 
#tiene que heredar de Gtk::Window
class RubyApp < Gtk::Window
 
   #constructor de la clase
   
   def initialize
        super
	#atributos de clase
	@fixed= Gtk::Fixed.new #crea un contenedor de tipo fixed vacío
	@combo= Gtk::ComboBox.new #crea un combobox vacío
	@menu= Gtk::MenuBar.new #crea una barra de menu vacía
	@boton= Gtk::Button.new "¿Qué Creo?" #crea un botón y le da valor al label
        set_windows
    end
 
    #setea los valores de la ventana
   def set_windows
	set_title  "Ruby y GTK+" #nombre de la ventana
	set_default_size 350, 300 #tamaño de la ventana
	set_window_position Gtk::Window::POS_CENTER #posicion de la ventana
	add fixed_main([combo_box, menu_bar, boton]) #llama a fixed_main para crear un contenedor
	show_all #muestra todo
	signal_connect "destroy" do 
	    Gtk.main_quit #cuando se le da click al boton cerrar se cierra el programa
	end
   end
    #agrega widgets al contenedor @fixed
    def fixed_main(widgets)
      widgets.each do | widget|
	  @fixed.put widget[0], widget[1], widget[2]
      end
      @fixed
    end
 
    #agrega valores al atributo @combo
    def combo_box
      contenido = ["Yukihiro Matz", "Richard Stallman", "Linus Torvalds", 'Peter Mattis']
      contenido.each do |item|
        @combo.append_text item
      end
      [@combo,110,100]
    end
 
    #crea un menu y lo agrega al atributo @menu
    def menu_bar
      menues = {"Archivo" => ["Nuevo","Abrir","Salir"],
                "Ayuda" => "Acerca de.."}
      menues.each do |menu_key, item_value|
	    menu = Gtk::Menu.new
	    submenu = Gtk::MenuItem.new menu_key
	    if item_value.class == Array
	        item_value.each do |item_v|
	            item_menu = Gtk::MenuItem.new item_v
	            menu.append item_menu
	            widget_activo(item_menu,1) if item_v == "Salir"
		    widget_activo(item_menu,2) if item_v == "Acerca de..."
	        end
	    else
	        item_menu = Gtk::MenuItem.new item_value
	        menu.append item_menu
	        salir(item_menu,1) if item_value == "Salir"
		widget_activo(item_menu,2) if item_value == "Acerca de..."
	    end
	    submenu.set_submenu menu
	    @menu.append submenu
      end
      [@menu,0,0]
    end
 
    #cuando se activa un item del menu ejecuta el codigo
    def widget_activo(widget,tipo)
      widget.signal_connect "activate" do
	tipo == 1 ? Gtk.main_quit : about_dialogo #si el tipo es 1 cierra la aplicacion, caso contrario abre el about
      end
    end
 
    #setea el tooltip del @boton y agrega un metodo en caso que se haga un click
    def boton
      @boton.set_tooltip_text "Button widget"
      @boton.signal_connect "clicked" do |w,e|
	mensaje_dialogo(@combo.active_iter.to_s)
      end
      [@boton,150,60]
    end
 
    #muestra un diálogo según el valor pasado
    def mensaje_dialogo(index)
      mensaje = case index
		  when "0" 
		    "Creador del lenguaje Ruby."
		  when "1" 
		    "Creador del Proyecto GNU."
		  when "2" 
		    "Creador del kernel Linux y Git."
		  when "3" 
		    "Creador del proyecto GTK+."  
		  else 
		    "No elegiste nada"
		end
      md = Gtk::MessageDialog.new(self,
	  Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::INFO, 
	  Gtk::MessageDialog::BUTTONS_CLOSE, mensaje)
      md.run
      md.destroy
    end
 
    #crea un diálogo about.
    def about_dialogo
        about = Gtk::AboutDialog.new
        about.set_program_name "GTK y Ruby 2016"
        about.set_version "1.0"
        about.set_copyleft " Andruwx Free"
        about.set_comments "Una muestra de lo que se puede hacer con Gtk y Ruby"
        about.set_logo Gdk::Pixbuf.new "ella.png"
        about.run
        about.destroy
    end
end
 #Ejecuta la aplicación
Gtk.init # con esta linea inicializamos la librería de gtk2
    window = RubyApp.new
Gtk.main
