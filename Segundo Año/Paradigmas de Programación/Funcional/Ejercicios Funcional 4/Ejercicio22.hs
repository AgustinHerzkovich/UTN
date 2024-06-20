{-
La  función takeWhile recibe una condición y una lista, y devuelve una nueva lista con los primeros que cumplan esa condición.
Lo que hace es recorrer la lista que se le manda, y va poniendo los valores que cumplan esa condición, mientras los haya, en una nueva lista.
Cuando se llega a un valor que no cumple la condición pedida, deja de cargar datos en la lista que retorna.
Por ejemplo, si hago takeWhile even [1,2,3,4] me va a retornar [], ya que el primer elemento ya no cumple con la condición, es decir que ahí termina.
Si hago takeWhile even [2,2,2,4,1,6] me devolverá [2,2,2,4] porque el 1 rompe la secuencia por ser impar y deja de cargar elementos en la lista.
-}

{-
Investigar lo que hace la función takeWhile/2, que está incluida en el prelude. Preguntar primero el tipo, y después hacer pruebas. Ayudarse con el nombre. 
-}