# Flex & Bison: Guía Práctica y Solución de Ejercicios

¡Hola! 👋 Este repositorio contiene una serie de ejemplos prácticos y ejercicios resueltos del libro **Flex & Bison** (Capítulo 1), diseñados para entender desde cero cómo funcionan el análisis léxico (*scanners*) y el análisis sintáctico (*parsers*).

---

## 📌 ¿Qué hay en este repositorio?

1. **Ejemplos del libro (1.1 al 1.6)**: El paso a paso desde un simple contador de palabras hasta una calculadora aritmética completa con manejo de precedencia.
2. **Ejercicios prácticos resueltos (Página 37)**: Calculadora hexadecimal, soporte de operadores a nivel de bits (`&`, `|`, `^`, `~`), comparación con escáneres manuales en C y análisis de limitaciones.
3. **Guías en PDF**: Documentos descargables con explicaciones detalladas y diagramas visuales.

---

## 🚀 Estructura de los Ejemplos

### Parte 1: Primeros pasos con Flex (Escáneres independientes)

* **[fb1-1.l](fb1-1.l)**: Simula el comando `wc` de Unix. Cuenta caracteres, palabras y líneas leyendo desde la terminal.
* **[fb1-2.l](fb1-2.l)**: Un traductor sencillo que reemplaza palabras en inglés británico por inglés americano (`colour` &rarr; `color`).
* **[fb1-3.l](fb1-3.l)**: Escáner básico que reconoce operadores matemáticos (`+`, `-`, `*`, `/`) y números, imprimiendo el nombre del token.
* **[fb1-4.l](fb1-4.l)**: Introduce el concepto de valores semánticos. Devuelve códigos numéricos de tokens y pasa el valor del número usando `yylval`.

### Parte 2: Flex + Bison trabajando juntos

* **[fb1-5.y](fb1-5.y)** + **[fb1-5.l](fb1-5.l)**:
  * `fb1-5.y` (Bison): Define la gramática formal y se asegura de que `2 + 3 * 4` dé `14` y no `20` (precedencia de operadores).
  * `fb1-5.l` (Flex): Lee los caracteres y le entrega los tokens al parser usando la cabecera `fb1-5.tab.h`.

---

## 💡 Ejercicios Resueltos (Capítulo 1 / Página 37)

| Ejercicio | Archivos | ¿De qué trata? |
| :--- | :--- | :--- |
| **1. Líneas de comentarios** | Explicado en PDF | Por qué una línea con solo `// comentario` da error de sintaxis y cómo arreglarlo en Bison con `calclist: ... \| calclist EOL`. |
| **2. Calculadora Hex y Dec** | `ejercicio_2_hex.l`<br>`ejercicio_2_hex.y` | Acepta números en hexadecimal (`0x1A`) y decimal, mostrando el resultado en ambas bases. |
| **3. Operadores Bitwise** | `ejercicio_3_bitwise.l`<br>`ejercicio_3_bitwise.y` | Agrega `&`, `\|`, `^` y `~`, resolviendo el conflicto de la barra vertical `\|` (valor absoluto vs. OR a nivel de bits). |
| **4. Escáner Manual vs. Flex** | Explicado en PDF | Comparativa técnica entre escribir un lexer a mano en C con `getc()` vs. usar Flex. |
| **5. Lenguajes no aptos para Flex** | Explicado en PDF | Análisis de casos donde Flex se queda corto (Python por indentación, C++ por *Lexer Hack*, Fortran por falta de palabras reservadas). |
| **6. Word Count en C puro** | `ejercicio_6_wc.c` | Reescritura optimizada de `wc` en C con lectura en búferes (`fread` de 64KB) y medición de rendimiento. |

---

## 🛠️ ¿Cómo compilar y probar los programas?

### 1. Requisitos
Necesitas tener instalado:
* **GCC** (o cualquier compilador de C como Clang/MSVC)
* **Flex**
* **Bison**

> *(En Linux/WSL: `sudo apt install flex bison gcc`. En Windows puedes usar MSYS2 o Win-Flex-Bison).*

---

### 2. Comandos de compilación

#### Para los ejemplos básicos de solo Flex (1.1 al 1.4):
```bash
# Ejemplo 1.1 (Contador de palabras)
flex fb1-1.l
gcc lex.yy.c -o fb1-1
./fb1-1
```

#### Para los ejemplos combinados de Flex + Bison (1.5 + 1.6):
```bash
# 1. Bison genera el parser y el archivo de cabecera (.h)
bison -d fb1-5.y

# 2. Flex genera el analizador léxico
flex fb1-5.l

# 3. Compilamos todo junto
gcc fb1-5.tab.c lex.yy.c -o fb1-5

# 4. Lo ejecutamos
./fb1-5
```

#### Para la Calculadora Hexadecimal (Ejercicio 2):
```bash
bison -d ejercicio_2_hex.y
flex ejercicio_2_hex.l
gcc ejercicio_2_hex.tab.c lex.yy.c -o calc_hex
./calc_hex
```

#### Para la Calculadora con Operadores Bitwise (Ejercicio 3):
```bash
bison -d ejercicio_3_bitwise.y
flex ejercicio_3_bitwise.l
gcc ejercicio_3_bitwise.tab.c lex.yy.c -o calc_bitwise
./calc_bitwise
```

#### Para el Word Count en C puro (Ejercicio 6):
```bash
gcc -O2 ejercicio_6_wc.c -o wc_c
./wc_c fb1-1.l
```

---

## 📚 Documentos PDF incluidos

* 📘 **[Guia_Ejercicios_Flex_Bison_1.1_a_1.6.pdf](Guia_Ejercicios_Flex_Bison_1.1_a_1.6.pdf)**: Explicación teórica y estructurada de los primeros 6 ejemplos.
* 📕 **[Solucion_Ejercicios_Flex_Bison_Pag_37.pdf](Solucion_Ejercicios_Flex_Bison_Pag_37.pdf)**: Solucionario completo y detallado con todas las preguntas teóricas y ejercicios de la página 37.

---
Hecho con fines educativos para el estudio de compiladores y lenguajes de programación.
