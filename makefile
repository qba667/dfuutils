# Makefile

CC := gcc
LD := g++

NAME  := dfuutils


ifeq ($(OS), Windows_NT)
	RM = del /Q
	BIN   := $(NAME).dll
else
	RM := rm -rf
	BIN   := $(NAME).so
endif

# Toolchain arguments.
CFLAGS    := 
CXXFLAGS  := $(CFLAGS)
LDFLAGS   := 
LUSB_INC  := -I../libusb-1.0.22/include
LIBS      := -L../libusb-1.0.22/MinGW32/dll -llibusb-1.0

SOURCES = intel_hex dfu stm32mem

# Project sources.
C_SOURCE_FILES := intel_hex.c dfu.c stm32mem.c
C_OBJECT_FILES := $(patsubst %.c,%.o,$(C_SOURCE_FILES))

# The dependency file names.
DEPS := $(C_OBJECT_FILES:.o=.d)

all: $(BIN)

clean:
	$(RM) $(C_OBJECT_FILES) $(DEPS) $(BIN)

rebuild: clean all

$(BIN): $(C_OBJECT_FILES)
	$(LD) -shared $(C_OBJECT_FILES) $(LDFLAGS) -o $@ $(LIBS) -Wl,--output-def,$(NAME).def,--out-implib,$@.a
	
%.o: %.c
	$(CC) $(LUSB_INC) -c -MMD -MP $< -o $@ $(CFLAGS)

# Let make read the dependency files and handle them.
-include $(DEPS)

