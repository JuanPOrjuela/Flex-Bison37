# Flex & Bison: Solución de Ejercicios Prácticos (Página 37)

Este repositorio tiene los ejercicios de la pagina 37 del libro flex y bison que hemos trabajado en clase.

Aqui vamos a tener los ejercicios y una pequeña explicacion de lo que tratan.

---

## Contenido del Repositorio

| Ejercicio | Archivos | Descripción rápida |
| :--- | :--- | :--- |
| **1. Líneas de comentarios** |  *(Explicado abajo)* | Análisis de por qué una línea con solo `// comentario` da error de sintaxis y cómo solucionarlo en el parser de Bison. |
| **2. Calculadora Hex & Dec** | `ejercicio_2_hex.l`<br>`ejercicio_2_hex.y` | Calculadora que reconoce números en hexadecimal (`0x1A`) y decimal (`26`), imprimiendo el resultado en ambos formatos. |
| **3. Operadores a nivel de bits** | `ejercicio_3_bitwise.l`<br>`ejercicio_3_bitwise.y` | Agrega `&` (AND), `\|` (OR), `^` (XOR) y `~` (NOT), resolviendo la ambigüedad del símbolo `\|` (OR binario vs. valor absoluto unario). |
| **4. Escáner manual vs. Flex** | *(Explicado abajo)* | Comparación técnica entre el lexer manual en C y la versión generada con Flex. |
| **5. Lenguajes no aptos para Flex** | *(Explicado abajo)* | Casos donde las expresiones regulares de Flex se quedan cortas (Python, C++, Fortran, etc.). |
| **6. Word Count en C puro** | Práctico (C) | `ejercicio_6_wc.c` | Reescritura del contador de palabras en C con lectura en bloques (`fread` 64KB), medición de tiempo de ejecución y comparativa con Flex. |

---

## Respuestas Teóricas

###  Ejercicio 1: Por qué falla una línea con solo un comentario?
* **Causa**: El escáner ignora el texto del comentario `// ...` sin retornar token, pero al ver el salto de línea `\n` retorna `EOL`. En Bison, la regla `calclist` espera recibir una expresión obligatoria antes de `EOL`. Al llegarle `EOL` solo, el parser no sabe qué hacer y lanza `syntax error`.
* **Solución recomendada**: Es mucho mejor arreglarlo en el **parser** añadiendo la regla `calclist: ... | calclist EOL;`. Así se admiten tanto líneas de comentarios como líneas vacías (Enter) sin afectar expresiones con comentarios al final (`2 + 2 // suma`).

###  Ejercicio 4: El escáner manual reconoce lo mismo que Flex 1-4?
* **No exactamente**: El escáner manual incluye soporte para comentarios `//` y paréntesis `(` y `)` que no estaban en el ejemplo 1-4. Además, maneja los errores mediante `yyerror()` en un bucle y usa `getc()` / `ungetc()` para distinguir entre la división `/` y el inicio de comentario `//`.

###  Ejercicio 5: Para qué lenguajes Flex no es la mejor opción?
1. **Indentación significativa (Off-side rule)**: Lenguajes como *Python*, *Haskell* o *YAML*, donde los bloques se definen por espacios y se requiere emitir tokens artificiales `INDENT` y `DEDENT`.
2. **Contexto dependiente de la tabla de tipos (*Lexer Hack*)**: *C/C++*, donde `T(x);` es declaración o llamada según si `T` es un tipo o no.
3. **Sin palabras reservadas o espacios libres**: *Fortran clásico* (`DO 10 I = 1.10` es una asignación, `DO 10 I = 1,10` es un bucle).
4. **Interpolación de strings anidados**: Lenguajes como *Kotlin* o *JavaScript (template literals)* que permiten expresiones completas anidadas dentro de cadenas.

---

##  compilar y probar los ejercicios 

### Requisitos
* Compilador de C (Nosotros usamos gcc)
* **Flex**
* **Bison**

---

### 1. Probar la Calculadora Hexadecimal y Decimal (Ejercicio 2)
```bash
bison -d ejercicio_2_hex.y
flex ejercicio_2_hex.l
gcc ejercicio_2_hex.tab.c lex.yy.c -o calc_hex

# Ejecutar
./calc_hex
```
*Probar ingresando:* `0x10 + 15` o `(0xFF - 5) * 2` &rarr; Nos devolverá el resultado tanto en decimal como en hexadecimal.

---

### 2. Probar la Calculadora Bitwise (Ejercicio 3)
```bash
bison -d ejercicio_3_bitwise.y
flex ejercicio_3_bitwise.l
gcc ejercicio_3_bitwise.tab.c lex.yy.c -o calc_bitwise

# Ejecutar
./calc_bitwise
```
*Probar ingresando:* `0xFF & 0x0F` o `5 ^ 3` o `~0` &rarr; Nos devolverá el resultado en decimal, hexadecimal y binario formateado.

---

### 3. Probar el Word Count en C puro (Ejercicio 6)
```bash
gcc -O2 ejercicio_6_wc.c -o wc_c

# Ejecutar pasándole cualquier archivo
./wc_c ejercicio_6_wc.c
```

