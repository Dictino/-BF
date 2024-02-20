### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ fdf959e9-f520-4f83-8ced-0e85d8961b28
begin
	using PlutoUI
	using HypertextLiteral
end

# ╔═╡ ee5f0ea0-796c-11ee-0752-ab40680845bb
md"""# Este es un intérprete de BK para jugar y también un compilador optimizador
- ">" Incrementa el puntero.
- "<"	Decrementa el puntero.
- "+"	Incrementa el byte apuntado.
- "-"	Decrementa el byte apuntado.
- "."	Escribe el byte apuntado en el flujo de salida.
- ","	Lee un byte del flujo de entrada y lo almacena en el byte apuntado.
- "["	Avanza a la instrucción inmediatamente posterior al ] correspondiente si el byte -actualmente apuntado es nulo (si es 0).
- "]"	Retrocede a la instrucción inmediatamente posterior al [ correspondiente si el byte actualmente apuntado no es nulo (si es distinto de 0).

"""

# ╔═╡ a5872709-8caa-42a9-8ad2-c064f4d4b525
md"Ejemplos de https://gist.github.com/roachhd/dce54bec8ba55fb17d3a"

# ╔═╡ 733ab11b-85cd-482b-beee-c7e1b32e7f08
hola_mundo=">+++++++++[<++++++++>-]<.>+++++++[<++++>-]<+.+++++++..+++.[-]
>++++++++[<++++>-] <.>+++++++++++[<++++++++>-]<-.--------.+++
.------.--------.[-]>++++++++[<++++>- ]<+.[-]++++++++++."

# ╔═╡ a0a925ad-f092-4dc5-8827-1cea7760496f
md"Programas de utilidad"

# ╔═╡ 4d7a22dc-8893-42e3-a144-48267501cd9d
CAT=">,[>,]<[<]>[.>]"

# ╔═╡ f81acfb9-7718-4ddd-8a44-dc407321c8ca
function MOVER(n)
	#mueve el valor apuntado n veces a la derecha (o izqueirda si es negativo)
	if n>0 
	   return "[" * ">"^n * "+" * "<"^n * "-]"
	else
	   return  "[" * "<"^abs(n) * "+" * ">"^abs(n) * "-]"
	end
end

# ╔═╡ 2752ab54-06d9-40f0-8c5e-8509cf5f5e84
function COPIAR(;destino=1, temporal=destino+1)
	#temporal indica el desplazamiento desde el valor de destino
	#copia un dato a la posición de destino usando la posición temporal temporal
	#supone que las posiciones de destino y temporal están a cero
	if temporal <= destino
		return "No deben de usarse como temporales posiciones a la izquierda del destino"
	end

	doble_copia= "[" * ">"^destino * "+" * ">"^(temporal-destino) * "+" * "<"^temporal * "-]"

	return  doble_copia * ">"^(temporal) * MOVER(-temporal) * "<"^(temporal)
end

# ╔═╡ 47db8ac0-2f59-4fff-b1ec-740d606e154d
ZERO="[-]"

# ╔═╡ a9e5606f-b30e-4fbe-ac1a-44ae68db2ccc
function INCREMENTO(n)
	#incrementa en positivo o negativo hasta +-999
    unidad=abs(n)%10
	decena=((abs(n)-unidad) ÷ 10)%10
	centena=(abs(n)-10*decena-unidad)÷100
	if n>=0
		codigo_unidad="+"^unidad
		codigo_decena=">" * "+"^decena * "[<++++++++++>-]<"
		codigo_centena=">++++++++++[<++++++++++>-]<"^centena
	else
		codigo_unidad="-"^unidad
		codigo_decena=">" * "+"^decena * "[<---------->-]<"
		codigo_centena=">++++++++++[<---------->-]<"^centena
	end	
	return codigo_centena*codigo_decena*codigo_unidad
end

# ╔═╡ 7c625cea-844f-4ccc-a417-928fed9c07fb
function IMPRIMIR_TEXTO(texto)
	#para ser más eficiente parto del primer caracter y voy incrementando/decrementando desde ahí
	numeros=Int.(Vector{UInt8}(texto))
	incrementos=diff(numeros)
	codigo=INCREMENTO(numeros[1]) * "." * prod([INCREMENTO(n)*"." for n in incrementos])
end

# ╔═╡ 8ea590b9-97b5-4a54-83a3-30e59ec804f1
function SUMAR

	#TO DO"+++++>+++[<+>-]"
end

# ╔═╡ deea9652-ccfb-4d6d-a4ff-a4f87f28421f
function RESTAR 
	#TODO +++++>+++[<->-]
end

# ╔═╡ 261dffd9-0921-4dd5-89ff-419aa42e6549
function MULTIPLICAR 
		#TO DO +++[>+++++<-]
end

# ╔═╡ e220d469-4577-495d-bdfd-38b0133ced28
function DIVIDIR 
		#TO DO +++[>+++++<-] poner menos por ahí...
end

# ╔═╡ 8691fa0a-8092-47eb-87aa-982b3733e4da
function IF(condición,acción)
	#TO DO
end

# ╔═╡ 84884387-b436-45ca-ac88-81c5470a8cdd
function WHILE(condición, acción)
	#TO DO
end

# ╔═╡ f4e3837f-009c-444a-994c-7870e6d0b034
function MAYOR()
	#TO DO
end

# ╔═╡ d09831c3-6b7e-4caa-8530-4894b96c127c
function MENOR()
	#TO DO
end

# ╔═╡ 5abb7154-190c-4b30-be8d-df379209e17c
function IGUAL()
	#TO DO
end

# ╔═╡ 2d8f5354-4221-4adb-bd84-84e18d5c863c
COMPILADOR_KATIE=
"""	
[/* bf2c.b
* The Brainfuck to C interpretor
* Katie ball
*
* NOTE: This was rushed and currently
* it does not take well to any characters of input besides
* the 8 standard brainfuck operators and newline and EOF.
* So consequently, it will only interpret un-commented code.
* Check my web site for a later release
* that will probably have support for commented code.
*/]


>+++++[>+++++++<-]>.<<++[>+++++[>+++++++<-]<-]>>.+++++.<++[>-----<-]>-.<++
[>++++<-]>+.<++[>++++<-]>+.[>+>+>+<<<-]>>>[<<<+>>>-]<<<<<++[>+++[>---<-]<-
]>>+.+.<+++++++[>----------<-]>+.<++++[>+++++++<-]>.>.-------.-----.<<++[>
>+++++<<-]>>.+.----------------.<<++[>-------<-]>.>++++.<<++[>++++++++<-]>
.<++++++++++[>>>-----------<<<-]>>>+++.<-----.+++++.-------.<<++[>>+++++++
+<<-]>>+.<<+++[>----------<-]>.<++[>>--------<<-]>>-.------.<<++[>++++++++
<-]>+++.---....>++.<----.--.<++[>>+++++++++<<-]>>+.<<++[>+++++++++<-]>+.<+
+[>>-------<<-]>>-.<--.>>.<<<+++[>>++++<<-]>>.<<+++[>>----<<-]>>.++++++++.
+++++.<<++[>---------<-]>-.+.>>.<<<++[>>+++++++<<-]>>-.>.>>>[-]>>[-]<+[<<[
-],[>>>>>>>>>>>>>+>+<<<<<<<<<<<<<<-]>>>>>>>>>>>>>>[<<<<<<<<<<<<<<+>>>>>>>>
>>>>>>-]<<+>[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-[-
[-[-[-[-[-[-[-[-[-[-[-[<->[-]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]<[
<<<<<<<<<<<<[-]>>>>>>>>>>>>[-]]<<<<<<<<<<<<[<+++++[>---------<-]>++[>]>>[>
+++++[>+++++++++<-]>--..-.<+++++++[>++++++++++<-]>.<+++++++++++[>-----<-]>
++.<<<<<<.>>>>>>[-]<]<<<[-[>]>>[>++++++[>+++[>++++++<-]<-]>>++++++.-------
------.----.+++.<++++++[>----------<-]>.++++++++.----.<++++[>+++++++++++++
++++<-]>.<++++[>-----------------<-]>.+++++.--------.<++[>+++++++++<-]>.[-
]<<<<<<<.>>>>>]<<<[-[>]>>[>+++++[>+++++++++<-]>..---.<+++++++[>++++++++++<
-]>.<+++++++++++[>-----<-]>++.<<<<<<.>>>>>>[-]<]<<<[-[>]>>[>+++[>++++[>+++
+++++++<-]<-]>>-.-----.---------.<++[>++++++<-]>-.<+++[>-----<-]>.<++++++[
>----------<-]>-.<+++[>+++<-]>.-----.<++++[>+++++++++++++++++<-]>.<++++[>-
----------------<-]>.+++++.--------.<++[>+++++++++<-]>.[-]<<<<<<<.>>>>>]<<
<[<+++[>-----<-]>+[>]>>[>+++++[>+++++++++<-]>..<+++++++[>++++++++++<-]>---
.<+++++[>----------<-]>---.<<<<<<.>>>>>>[-]<]<<<[--[>]>>[>+++++[>+++++++++
<-]>--..<+++++++[>++++++++++<-]>-.<+++++[>----------<-]>---.[-]<<<<<<.>>>>
>]<<<[<+++[>----------<-]>+[>]>>[>+++[>++++[>++++++++++<-]<-]>>-.<+++[>---
--<-]>.+.+++.-------.<++++++[>----------<-]>-.++.<+++++++[>++++++++++<-]>.
<+++++++[>----------<-]>-.<++++++++[>++++++++++<-]>++.[-]<<<<<<<.>>>>>]<<<
[--[>]>>[>+++++[>+++++[>+++++<-]<-]>>.[-]<<<<<<<.>>>>>]<<<[<++++++++++[>--
--------------<-]>--[>]>>[<<<<[-]]]]]]]]]]]>>]<++[>+++++[>++++++++++<-]<-]
>>+.<+++[>++++++<-]>+.<+++[>-----<-]>.+++++++++++.<+++++++[>----------<-]>
------.++++++++.-------.<+++[>++++++<-]>.<++++++[>+++++++++++<-]>.<+++++++
+++."""

# ╔═╡ 705fe69b-8637-4b3c-ba4a-ea063c679927
md"# Ejecución"

# ╔═╡ 439cc016-fab4-4003-8d73-dec4cc8b6138


# ╔═╡ bfa1e4cb-ef94-410e-906c-deb3637c4a72
texto="¡Hola Dictino!"

# ╔═╡ 39dc2e23-8e4b-44f3-9c07-8ffbeff02f92
Vector{UInt8}(texto)

# ╔═╡ d7e78c72-eef4-49cf-824e-8bfae33aaaa1
Int.(Vector{UInt8}(texto))

# ╔═╡ 248119d5-6c57-49b3-9bfb-7ebe602a88f6


# ╔═╡ 428bbc34-c105-4387-8a9e-31488677eea2
function mostrar_estado(estado,programa)
	memoria, puntero_memoria, puntero_codigo, puntero_entrada,salida=estado
	texto_delante=""
	for i in 1:(puntero_memoria-1)
	    texto_delante=texto_delante*"[$(memoria[i])]"
	end
    
	
	texto_actual="[$(memoria[puntero_memoria])]"
	
	texto_detrás=""
	for i in (puntero_memoria+1):10
	    texto_detrás=texto_detrás*"[$(memoria[i])]"
	end
	
	texto=htl"$texto_delante <strong> <font color=red> $texto_actual </font> </strong> $texto_detrás ..."
	
    pc=puntero_codigo
    texto2_delante=""
	for i in 1:(puntero_codigo-1)
	    texto2_delante=texto2_delante*"$(programa[i])"
	end
	texto2_actual="$(programa[puntero_codigo])"
	texto2_detrás=""
	for i in (puntero_codigo+1):length(programa)
	    texto2_detrás=texto2_detrás*"$(programa[i])"
	end
	texto2=htl"$texto2_delante <strong> <font color=red> $texto2_actual </font> </strong> $texto2_detrás ..."


	
    md"Salida=\"$salida\"
	
Memoria= $texto  

Programa:
	
$texto2"

end

# ╔═╡ e3d2ef58-69dd-4c07-8881-765992f683e3
md"# Ahí va el intérprete ;)"

# ╔═╡ 4894c2fb-80b6-4728-9d9f-8ca1088ae53f
#todo comprobar entradas, rangos, etc...
#mostrar errores
#convertir entrada a uint8??
#que la memória sea dinámica
#formateo más bonito
#que haga algo decente si no es ascii?
function interprete(programa,entrada,MAX_ITER=1e5)
	iteraciones=0
	puntero_codigo=1
	N=length(programa)
	puntero_entrada=1
	puntero_memoria=1
	salida = zeros(UInt8,0)
	memoria = zeros(UInt8,10)
	error=""
	historia=[]

	while((puntero_codigo<=N)&&(iteraciones<=MAX_ITER)&&(error==""))
		iteraciones=iteraciones+1
    	comando=programa[puntero_codigo]
		if comando=='>'
			if puntero_memoria==length(memoria)
				push!(memoria,0) #crecimiento dinámico
			end
			puntero_memoria=puntero_memoria+1
		elseif comando=='<'
			if puntero_memoria==1
				error="Se intenta apuntar a la posición de memoria 0"
			end
			puntero_memoria=puntero_memoria-1
		elseif comando=='+'
			memoria[puntero_memoria]=memoria[puntero_memoria]+0x1
		elseif comando=='-'
			memoria[puntero_memoria]=memoria[puntero_memoria]-0x1
		elseif comando=='.'
			salida=push!(salida,memoria[puntero_memoria])
		elseif comando==','
			if puntero_entrada > length(entrada)
				memoria[puntero_memoria]=0 #EOF
			else
			    memoria[puntero_memoria]=entrada[puntero_entrada]
			    puntero_entrada=puntero_entrada+1
			end
		elseif comando=='['
			if memoria[puntero_memoria]==0
				nivel=1
				temporal=puntero_codigo
				while(nivel>0)  #busco el ] que corresponde
					puntero_codigo=puntero_codigo+1
					if puntero_codigo>length(programa) #llego al final del programa
						error="No se encuentra ] correspondiente al [ de la posición $temp"
					else
					   if programa[puntero_codigo]=='['
					      nivel=nivel+1
					   elseif programa[puntero_codigo]==']'
					      nivel=nivel-1
					   end
					end
				end
			end
		elseif comando==']'
			if memoria[puntero_memoria]!=0
					nivel=1
					temporal=puntero_codigo
				while(nivel>0)  #busco el [ que corresponde
					puntero_codigo=puntero_codigo-1
					if puntero_codigo<1 #llego al principio del programa
						error="No se encuentra [ correspondiente al ] de la posición $temp"
					else
					   if programa[puntero_codigo]==']'
					   		nivel=nivel+1
						elseif programa[puntero_codigo]=='['
					   		nivel=nivel-1
						end
					end
				end
			end
		else
			#Es un comentario, no hacemos nada ;)
		end
		push!(historia, (memoria=copy(memoria),
		                 puntero_memoria=puntero_memoria,
		                 puntero_codigo=puntero_codigo,
		                 puntero_entrada=puntero_entrada,
		                 salida=String(copy(salida)),  
		                 resumen="TODO") )

		
		puntero_codigo=puntero_codigo+1
	end
return salida,historia,error
end


# ╔═╡ 23bd9b5f-f466-47bd-92e8-4650601cb07e
begin
	programa=IMPRIMIR_TEXTO("Hola")
	entrada="+++" * COPIAR(destino=1, temporal=5)
	salida,historia,errores=interprete(programa,entrada)
	salida
end

# ╔═╡ 787ccc8f-8a0c-4054-94ff-f1ae69dfa4a7
Int.(salida)

# ╔═╡ e7fd9cc9-9dbc-4ef6-95a1-02150e85be60
@bind n Slider(1:length(historia))

# ╔═╡ 11c6af62-1bcd-405b-944b-3e1503dd53db
n

# ╔═╡ 3d4e1107-65dc-46db-9c49-d4997f68a684
mostrar_estado(historia[n],programa)

# ╔═╡ 911e8e30-134f-4761-ad62-0ccae99de4e0
md"""
# Ahora vamos a por un compilador
En un primer paso generaremos un código intermedio que es un vector de tuplas

(op, num)

Donde las istrucciones inicialmente son

- I incrementar el valor num (puede ser negativo)
- IP incrementar el puntero el valor num (también puede ser negativo)
- [ num es el nivel de paréntesis 
- ] idem
- S salida del valor apuntado (ignoro el campo num de momento saco un byte siempre)
- E entrada, idem con num


La primera optimización (optimizar incrementos) es juntar varios incrementos en uno solo +++ --> I3: 

(I,num1), (I,num2)--> (I,num1+num2)

Para aumentar la eficiencia hay que es añadir la instrucción de asignación

- A asigna num a la posición de memoria

Eso permite optimizar patrones como [-]+++ que se convertirían en (A 3)

Para ello hacemos varios reemplazos/optimizaciones

[-] --> (A 0)

(A num1), (A num2) --> (A num2)

(A num1), (I num2) --> (A num1+num2)

(I num1), (A num2) --> (A num2)

Y esto se aplica tantas veces como se pueda

"""

# ╔═╡ 25f8ea02-4b74-496c-826c-270a82e122bb
function parsear(codigo)
IR=NamedTuple{(:comando, :num, :cod_original), Tuple{String, Int64, String}}[]
puntero_codigo=1
N=length(codigo)
NivelParentesis=0
error=""
	while((puntero_codigo<=N)&&(error==""))
    	comando=codigo[puntero_codigo]
		if comando=='>'
			push!(IR, (comando="IP",num=1,cod_original=">") )
		elseif comando=='<'
			push!(IR,(comando="IP",num=-1,cod_original="<"))
		elseif comando=='+'
			push!(IR,(comando="I",num=1,cod_original="+"))
		elseif comando=='-'
			push!(IR,(comando="I",num=-1,cod_original="-"))
		elseif comando=='.'
			push!(IR,(comando="S",num=1,cod_original="."))
		elseif comando==','
			push!(IR,(comando="E",num=1,cod_original=","))
		elseif comando=='['
			NivelParentesis=NivelParentesis+1
			push!(IR, (comando="[" , num=NivelParentesis ,cod_original="[") )
		elseif comando==']'
			push!(IR,(comando="]",num=NivelParentesis,cod_original="]"))
			NivelParentesis=NivelParentesis-1
			if NivelParentesis<0
				error=="Se cierran demasiados corchetes ] en comando $puntero_codigo"
				break
			end
		else
			#Es un comentario, no hacemos nada ;)
		end
		puntero_codigo=puntero_codigo+1;
	end
	#compruebio que los paréntesis encajan
	if NivelParentesis>0
		error="Faltan $NivelParentesis [ por cerrar"
	end
return IR,error
end

# ╔═╡ 23c2a720-3c59-451a-8e38-e1151d8253bc
IR, err=parsear(programa)

# ╔═╡ d489899f-ac4a-4338-a615-da538b600fb4
function Optimizar_incrementos(IR)
	IR_op=NamedTuple{(:comando, :num, :cod_original), Tuple{String, Int64, String}}[]
	N=length(IR)
	i=1
	while i<=N
		if IR[i].comando=="I"
			incremento=0
			codigo=""
			#bucle que intenta agregar todos los incrementos que pueda
			while  i<=N && IR[i].comando=="I"
				incremento=incremento+IR[i].num
				codigo=codigo*IR[i].cod_original #agrego el codigo para ver la procedencia de la instruccion optimizada
				i=i+1
			end
			push!(IR_op,(comando="I",num=incremento, cod_original=codigo))
		else
			#copio el comando sin más
			push!(IR_op,IR[i])
			i=i+1
		end
	end
	return IR_op
end
		

# ╔═╡ 9c411c42-3f85-4809-857e-fed9c5ff1cdd
IR2=Optimizar_incrementos(IR)

# ╔═╡ 502ab22c-d624-4828-b2e6-324716e0e1e7
function Optimizar_asignaciones(IR)
	cambia=false
	i=1
	IR_op=[]
	N=length(IR)
	#hago una pasada
	while i<=N
		
		#[-] --> (A 0)
		if (i+2)<=N && IR[i].comando=="[" && IR[i+1].comando=="I" &&   #[-]
		               IR[i+1].num==-1 && IR[i+2].comando=="]"  
			
			codigo=IR[i].cod_original*IR[i+1].cod_original*IR[i+2].cod_original
			push!(IR_op,(comando="A",num=0, cod_original=codigo))
			i=i+3
			cambia=true
			
		#(A num1), (A num2) –> (A num2)	
		elseif (i+1)<=N && IR[i].comando=="A" && IR[i+1].comando=="A"  
			
			codigo=IR[i].cod_original*IR[i+1].cod_original
			push!(IR_op,(comando="A",num=IR[i+1].num, cod_original=codigo))
			i=i+2
			cambia=true
			
		#(A num1), (I num2) –> (A num1+num2)
		elseif (i+1)<=N && IR[i].comando=="A" && IR[i+1].comando=="I"  
			
			codigo=IR[i].cod_original*IR[i+1].cod_original
			num=IR[i].num+IR[i+1].num
			push!(IR_op,(comando="A",num=num, cod_original=codigo))
			i=i+2
			cambia=true
			
		#(I num1), (A num2) –> (A num2)
		elseif (i+1)<=N && IR[i].comando=="I" && IR[i+1].comando=="A"  
			
			codigo=IR[i].cod_original*IR[i+1].cod_original
			push!(IR_op,(comando="A",num=IR[i+1].num, cod_original=codigo))
			i=i+2
			cambia=true

		else
			push!(IR_op,IR[i])
			i=i+1
		end
	end
	#si no cambia ya he acabado, si no uso recursión hasta que deje de hacerlo
	if cambia
        IR_op=Optimizar_asignaciones(IR_op)
	end
	return IR_op
end

# ╔═╡ 324b3ceb-d828-45fe-9973-b1158596a369
md"""
# Finalmente compilo
Compilo, evaluo la función y compruebo que funciona comparando la salilda con el intérprete
"""

# ╔═╡ e2db7d7a-7c68-4436-9eed-ea775001066e
function generar_codigo(IR;Numero_celdas=30000)
	preambulo="""
	function compilado(entrada)
	    #preámbulo
	    puntero_m=1
	    salida = zeros(UInt8,0)
	    memoria = zeros(UInt8,$Numero_celdas)
	"""

	cuerpo=String[]
	NivelIdentacion=1
	identacion=" "^(4*NivelIdentacion)

	for instrucción in IR
		    push!(cuerpo,"\n")
			push!(cuerpo,identacion)
			push!(cuerpo,"#$(instrucción.cod_original) \n")
		
		if instrucción.comando=="IP"
			push!(cuerpo,identacion)
		    push!(cuerpo,"puntero_m=puntero_m + ($(instrucción.num))\n")
			push!(cuerpo,identacion)
		    push!(cuerpo,"if puntero_m > $Numero_celdas\n")
			push!(cuerpo,identacion)
		    push!(cuerpo,"""    Base.error("Puntero demasiado grande puntero_m=\$puntero_m")\n""")
			push!(cuerpo,identacion)
			push!(cuerpo,"end\n")
			push!(cuerpo,identacion)
			push!(cuerpo,"if puntero_m<1\n")
			push!(cuerpo,identacion)
			push!(cuerpo,"""    Base.error("Puntero demasiado pequeño puntero_m=\$puntero_m")\n""")
			push!(cuerpo,identacion)
			push!(cuerpo,"end\n")
			
		elseif instrucción.comando=="I"
			push!(cuerpo,identacion)
			valor="0x"*string(mod(instrucción.num,256),base=16) #para que sea un uint8
		    push!(cuerpo,"memoria[puntero_m]=memoria[puntero_m] + $(valor)")
			
		elseif instrucción.comando=="S"
			push!(cuerpo,identacion)
		    push!(cuerpo,"push!(salida,memoria[puntero_m])")
			
		elseif instrucción.comando=="E"
			push!(cuerpo,identacion)
			push!(cuerpo,"push!(salida,memoria[puntero_m])")
			
		elseif instrucción.comando=="["
			push!(cuerpo,identacion)
			push!(cuerpo, "while memoria[puntero_m]!=0")
			NivelIdentacion=NivelIdentacion+1
			identacion=" "^(4*NivelIdentacion)
			
		elseif instrucción.comando=="]"
			NivelIdentacion=NivelIdentacion-1
			identacion=" "^(4*NivelIdentacion)
			push!(cuerpo,identacion)
			push!(cuerpo, "end")

		elseif instrucción.comando=="A"
			push!(cuerpo,identacion)
			valor="0x"*string(mod(instrucción.num,256),base=16)
			push!(cuerpo,"memoria[puntero_m] = $valor")
			
		else
			error("instrucción no valida: $instrucción.comando")
		end
		push!(cuerpo,"\n")
	end

    fin="""
	    return salida
	end
	"""

	codigo=preambulo*join(cuerpo)*fin
	return codigo
end


# ╔═╡ 72cd72a7-5767-4e68-9b47-b85bfe4edaf1
begin
	codigo=generar_codigo(IR2)
	#println(codigo)
end

# ╔═╡ 452c9440-e6b4-426b-aa46-2c01c4558e04
md"ahora todo junto"

# ╔═╡ 63b418b2-6c3c-40cb-9c2c-b48ce8eb5113
function compilar(programa)
		IR, err=parsear(programa)
		IR2=Optimizar_incrementos(IR)
	    IR3=Optimizar_asignaciones(IR2)
		codigo=generar_codigo(IR3)
		#println(codigo)
		ex=Meta.parse(codigo)
		eval(ex)
	    return IR,IR2,IR3,codigo
end

# ╔═╡ e3b4d45e-e22f-442f-a3f2-35a1db070540
begin
    dummie=1
	compilar(programa)
    #compilar("+++[-]+-+++-[-]+")
end

# ╔═╡ d06651e1-27f7-4772-86cf-b93f36f22f04


# ╔═╡ 5f5d1af8-de06-470d-86f5-e15a62aca696
begin
	dummie
	String(compilado(entrada))
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
HypertextLiteral = "~0.9.5"
PlutoUI = "~0.7.52"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "98f4f9b67ee4d67da87eae57a18fa4e682f2e721"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "91bd53c39b9cbfb5ef4b015e8b582d344532bd0a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+2"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "716e24b21538abc91f6205fd1d8363f39b442851"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "e47cd150dbe0443c3a3651bc5b9cbd5576ab75b7"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.52"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─ee5f0ea0-796c-11ee-0752-ab40680845bb
# ╠═fdf959e9-f520-4f83-8ced-0e85d8961b28
# ╟─a5872709-8caa-42a9-8ad2-c064f4d4b525
# ╟─733ab11b-85cd-482b-beee-c7e1b32e7f08
# ╟─a0a925ad-f092-4dc5-8827-1cea7760496f
# ╟─4d7a22dc-8893-42e3-a144-48267501cd9d
# ╟─f81acfb9-7718-4ddd-8a44-dc407321c8ca
# ╟─2752ab54-06d9-40f0-8c5e-8509cf5f5e84
# ╟─47db8ac0-2f59-4fff-b1ec-740d606e154d
# ╟─a9e5606f-b30e-4fbe-ac1a-44ae68db2ccc
# ╟─7c625cea-844f-4ccc-a417-928fed9c07fb
# ╠═8ea590b9-97b5-4a54-83a3-30e59ec804f1
# ╠═deea9652-ccfb-4d6d-a4ff-a4f87f28421f
# ╠═261dffd9-0921-4dd5-89ff-419aa42e6549
# ╠═e220d469-4577-495d-bdfd-38b0133ced28
# ╠═8691fa0a-8092-47eb-87aa-982b3733e4da
# ╠═84884387-b436-45ca-ac88-81c5470a8cdd
# ╠═f4e3837f-009c-444a-994c-7870e6d0b034
# ╠═d09831c3-6b7e-4caa-8530-4894b96c127c
# ╠═5abb7154-190c-4b30-be8d-df379209e17c
# ╟─2d8f5354-4221-4adb-bd84-84e18d5c863c
# ╟─705fe69b-8637-4b3c-ba4a-ea063c679927
# ╠═439cc016-fab4-4003-8d73-dec4cc8b6138
# ╠═39dc2e23-8e4b-44f3-9c07-8ffbeff02f92
# ╠═d7e78c72-eef4-49cf-824e-8bfae33aaaa1
# ╠═787ccc8f-8a0c-4054-94ff-f1ae69dfa4a7
# ╠═bfa1e4cb-ef94-410e-906c-deb3637c4a72
# ╠═248119d5-6c57-49b3-9bfb-7ebe602a88f6
# ╠═23bd9b5f-f466-47bd-92e8-4650601cb07e
# ╠═e7fd9cc9-9dbc-4ef6-95a1-02150e85be60
# ╠═11c6af62-1bcd-405b-944b-3e1503dd53db
# ╟─3d4e1107-65dc-46db-9c49-d4997f68a684
# ╟─428bbc34-c105-4387-8a9e-31488677eea2
# ╟─e3d2ef58-69dd-4c07-8881-765992f683e3
# ╟─4894c2fb-80b6-4728-9d9f-8ca1088ae53f
# ╟─911e8e30-134f-4761-ad62-0ccae99de4e0
# ╟─25f8ea02-4b74-496c-826c-270a82e122bb
# ╠═23c2a720-3c59-451a-8e38-e1151d8253bc
# ╟─d489899f-ac4a-4338-a615-da538b600fb4
# ╠═9c411c42-3f85-4809-857e-fed9c5ff1cdd
# ╟─502ab22c-d624-4828-b2e6-324716e0e1e7
# ╟─324b3ceb-d828-45fe-9973-b1158596a369
# ╟─e2db7d7a-7c68-4436-9eed-ea775001066e
# ╠═72cd72a7-5767-4e68-9b47-b85bfe4edaf1
# ╟─452c9440-e6b4-426b-aa46-2c01c4558e04
# ╠═63b418b2-6c3c-40cb-9c2c-b48ce8eb5113
# ╠═e3b4d45e-e22f-442f-a3f2-35a1db070540
# ╠═d06651e1-27f7-4772-86cf-b93f36f22f04
# ╠═5f5d1af8-de06-470d-86f5-e15a62aca696
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
