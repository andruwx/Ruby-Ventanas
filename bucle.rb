 # coding: IBM850
=begin
Este es un programa, juego, con el que se pretende llevar a cabo un bucle
hasta que el usuario quiera terminarlo.
Registra las respuestas y las muestra
=end
@veces=0
@matriz=[]
puts
puts "Juguemos a un bucle"
puts "Cuando quieras terminar presiona t ó T"
puts
15.times do print "=" end
puts
def bucle
@veces+=1
@matriz<<@resp
puts "No digo que me digas *** #{@resp} ***"
puts "Te pregunto que"
pregunta
end
def terminar
puts
puts "Vale, ya terminamos el bucle"
puts
puts "Has contestado #{@veces} veces"
puts
puts "Has escrito estas respuestas:"
puts
for k in (0..@veces-1)
puts "Respuesta #{k+1} = #{@matriz[k]}"
end
puts
end
def pregunta
puts "¿Quieres que te cuente un cuento que nunca se acabe?"
STDOUT.flush
@resp=gets.chomp
case @resp
when "t"
terminar
when "T"
terminar
else
bucle
end
end
pregunta
 
