/* Ejercicio 6: Implementacion pura en C del programa Word Count (wc) */
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <time.h>

#define BUFFER_SIZE 65536

void count_file(FILE *fp, const char *filename, long *total_lines, long *total_words, long *total_chars) {
    long lines = 0;
    long words = 0;
    long chars = 0;
    int in_word = 0;
    
    char buffer[BUFFER_SIZE];
    size_t bytes_read;

    while ((bytes_read = fread(buffer, 1, BUFFER_SIZE, fp)) > 0) {
        chars += bytes_read;
        for (size_t i = 0; i < bytes_read; i++) {
            char c = buffer[i];
            if (c == '\n') {
                lines++;
            }
            if (isalpha((unsigned char)c)) {
                if (!in_word) {
                    words++;
                    in_word = 1;
                }
            } else {
                in_word = 0;
            }
        }
    }

    *total_lines += lines;
    *total_words += words;
    *total_chars += chars;

    printf("%8ld %8ld %8ld %s\n", lines, words, chars, filename ? filename : "");
}

int main(int argc, char **argv) {
    clock_t start = clock();
    long total_lines = 0, total_words = 0, total_chars = 0;

    if (argc < 2) {
        /* Leer desde stdin */
        count_file(stdin, NULL, &total_lines, &total_words, &total_chars);
    } else {
        /* Procesar cada archivo pasado como argumento */
        for (int i = 1; i < argc; i++) {
            FILE *fp = fopen(argv[i], "rb");
            if (!fp) {
                perror(argv[i]);
                continue;
            }
            count_file(fp, argv[i], &total_lines, &total_words, &total_chars);
            fclose(fp);
        }
        if (argc > 2) {
            printf("%8ld %8ld %8ld total\n", total_lines, total_words, total_chars);
        }
    }

    clock_t end = clock();
    double cpu_time = ((double)(end - start)) / CLOCKS_PER_SEC;
    fprintf(stderr, "[Tiempo de ejecucion en C: %.4f segundos]\n", cpu_time);

    return 0;
}
