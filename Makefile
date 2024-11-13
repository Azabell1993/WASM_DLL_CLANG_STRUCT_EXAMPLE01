# Compiler and flags
CC = gcc
EMCC = emcc
CFLAGS = -c -DBUILD_MY_DLL -fPIC
LDFLAGS = -shared -Wl,--out-implib,lib-Calculator.a
EMCC_FLAGS = -s WASM=1 -s NO_EXIT_RUNTIME=1
HTML_TEMPLATE = html_template/shell_minimal.html

# Targets
TARGET_DLL = Calculator.dll
TARGET_WASM = Calculator.html
OBJS = Calculator.o

# Default target
all: $(TARGET_DLL) $(TARGET_WASM)

# Build shared library
$(TARGET_DLL): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $<

# Build WebAssembly module
$(TARGET_WASM): Calculator.c
	$(EMCC) $< $(EMCC_FLAGS) -o $@ --shell-file $(HTML_TEMPLATE)

# Compile object file
$(OBJS): Calculator.c
	$(CC) $(CFLAGS) -o $@ $<

# Clean up build files
clean:
	rm -f $(OBJS) $(TARGET_DLL) $(TARGET_WASM) *.wasm *.js

.PHONY: all clean

