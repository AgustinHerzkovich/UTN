%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%
%primeraMarca(Marca)
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto,Precio)
%donde Producto puede ser arroz(Marca), lacteo(Marca,TipoDeLacteo), salchicas(Marca,Cantidad)
precioUnitario(arroz(gallo),25.10).
precioUnitario(lacteo(laSerenisima,leche), 6.00).
precioUnitario(lacteo(laSerenisima,crema), 4.00).
precioUnitario(lacteo(gandara,queso(gouda)), 13.00).
precioUnitario(lacteo(vacalin,queso(mozzarella)), 12.50).
precioUnitario(salchichas(vienisima,12), 9.80).
precioUnitario(salchichas(vienisima, 6), 5.80).
precioUnitario(salchichas(granjaDelSol, 8), 5.10).

%compro(Cliente,Producto,Cantidad)
compro(juan,lacteo(laSerenisima,crema),2).

duenio(laSerenisima, gandara).
duenio(gandara, vacalin).

%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima,leche), 0.20).
descuento(lacteo(laSerenisima,crema), 0.70).
descuento(lacteo(gandara,queso(gouda)), 0.70).
descuento(lacteo(vacalin,queso(mozzarella)), 0.05).

%%%%%%%%%%%%
% Punto 01 %
%%%%%%%%%%%%
descuento(arroz(Marca), Descuento) :-
    precioUnitario(arroz(Marca), Precio),
    descuentoPrecio(Precio, 1.50, Descuento).
descuento(salchichas(Marca, _), Descuento) :-
    Marca \= vienisima,
    precioUnitario(salchichas(Marca, _), Precio),
    descuentoPrecio(Precio, 0.50, Descuento).
descuento(Lacteo, Descuento) :-
    lecheOQuesoPrimeraMarca(Lacteo),
    precioUnitario(Lacteo, Precio),
    descuentoPrecio(Precio, 2, Descuento).
descuento(Producto, 0,05) :-
    mayorPrecioUnitario(Producto).

mayorPrecioUnitario(Producto) :-
    precioUnitario(Producto, MayorPrecio),
    forall(precioUnitario(OtroProducto, MenorPrecio), MayorPrecio >= MenorPrecio).
    
lecheOQuesoPrimeraMarca(lacteo(_, leche)).
lecheOQuesoPrimeraMarca(lacteo(Marca, queso)) :-
    primeraMarca(Marca).

descuentoPrecio(Precio, Resta, Descuento) :-
    Descuento is ((Precio - Resta) / Precio) * 100.

%%%%%%%%%%%%
% Punto 02 %
%%%%%%%%%%%%
compradorCompulsivo(Cliente) :-
    cliente(Cliente),
    forall(compro(Cliente, Producto, _), primeraMarcaYDescuento(Producto)).

cliente(Cliente) :-
    compro(Cliente, _, _).

primeraMarcaYDescuento(Producto) :-
    marcaProducto(Producto, Marca),
    primeraMarca(Marca),
    tieneDescuento(Producto).

tieneDescuento(Producto) :-
    descuento(Producto, _).

marcaProducto(arroz(Marca), Marca).
marcaProducto(lacteo(Marca, _), Marca).
marcaProducto(salchichas(Marca, _), Marca).

%%%%%%%%%%%%
% Punto 03 %
%%%%%%%%%%%%
totalAPagar(Cliente, Total) :-
    findall(Subtotal, gasto(Cliente, Subtotal), Subtotales),
    sumlist(Subtotalales, Total).

gasto(Cliente, Gasto) :-
    compro(Cliente, Producto, Cantidad),
    precioConDescuento(Producto, Precio),
    Gasto is Precio * Cantidad.

precioConDescuento(Producto, PrecioDescuento) :-
    precioUnitario(Producto, PrecioUnitario),
    descuento(Producto, Descuento),
    PrecioDescuento is PrecioUnitario * (1 - Descuento).
    
%%%%%%%%%%%%
% Punto 04 %
%%%%%%%%%%%%
clienteFiel(Cliente, Marca) :-
    cliente(Cliente),
    forall(productosMismaMarca(Producto1, Producto2, Marca), noCompra(Cliente, Producto1, Producto2)).

noCompra(Cliente, Producto1, Producto2) :-
    not(compro(Cliente, Producto1, _)),
    not(compro(Cliente, Producto2, _)).

productosMismaMarca(Producto1, Producto2, Marca) :-
    marcaProducto(Producto1, Marca),
    marcaProducto(Producto2, Marca),
    Producto1 \= Producto2.

%%%%%%%%%%%%
% Punto 05 %
%%%%%%%%%%%%
provee(Empresa, Productos) :-
    productosQueProvee(Empresa, Productos).
provee(Empresa, Productos) :-
    tieneACargo(Empresa, SubEmpresa),
    productosQueProvee(SubEmpresa, Productos).

productosQueProvee(Empresa, Productos) :-
    esProveidoPor(Empresa, _),
    findall(Producto, esProveidoPor(Empresa, Producto), Productos).

esProveidoPor(Empresa, Producto) :-
    precioUnitario(Producto, _),
    marcaProducto(Producto, Empresa).

tieneACargo(Empresa, SubEmpresa) :-
    duenio(Empresa, SubEmpresa).
tieneACargo(Empresa, SubEmpresa) :-
    duenio(Empresa, EmpresaIntermedia),
    tieneACargo(EmpresaIntermedia, SubEmpresa).