# ====================================================================
#   TEMPLATE Makefile
# ====================================================================

# === Compiler and Source Configuration ===
CXX       = g++
# FIX 1: Remove commas (spaces only)
SRC       = main.cpp Window/Window.cpp Renderer/Renderer.cpp InputManager/InputManager.cpp InputManager/KeyLoader.cpp
OBJDIR    = obj
OBJ       = $(addprefix $(OBJDIR)/, $(SRC:.cpp=.o))
SRC_COUNT = $(words $(SRC))

# === OS Detection and Dependency Mapping ===
ifeq ($(OS),Windows_NT)
    # --- Windows Settings ---
    OUT       = engine.exe
    
    PKG_FLAGS_C := $(shell pkg-config --cflags sdl2 SDL2_image 2>nul)
    PKG_FLAGS_L := $(shell pkg-config --libs sdl2 SDL2_image 2>nul)

    ifneq ($(PKG_FLAGS_C),)
        CXXFLAGS  = -g $(PKG_FLAGS_C)
        LDFLAGS   = 
        LIBS      = $(PKG_FLAGS_L)
    else
        SDL_DIR  ?= C:/SDL/SDL2/src
        CXXFLAGS  = -g -I$(SDL_DIR)/include
        LDFLAGS   = -L$(SDL_DIR)/lib
        LIBS      = -lmingw32 -lSDL2main -lSDL2 -lSDL2_image
    endif

    TIME_CMD  = powershell -Command "$$t = Measure-Command { $(MAKE) --no-print-directory build }; Write-Host 'Built $(SRC_COUNT) source files in' ($$t.TotalSeconds) 'seconds.'"
    RM        = del /Q /F
    # FIX 2: Dynamic directory creation for subfolders (Window/, Renderer/)
    MKDIR     = powershell -Command "New-Item -ItemType Directory -Force -Path (Split-Path -Path '$@')" >nul 2>&1
    CLEAN_OBJ = $(OBJDIR)
else
    # --- Linux / macOS Settings ---
    UNAME_S := $(shell uname -s)
    OUT       = engine
    
    CXXFLAGS  = -g $(shell pkg-config --cflags sdl2 SDL2_image 2>/dev/null || sdl2-config --cflags)
    LDFLAGS   = 
    LIBS      = $(shell pkg-config --libs sdl2 SDL2_image 2>/dev/null || sdl2-config --libs) -lSDL2_image
    
    TIME_CMD  = sh -c 'echo "Compiling $(SRC_COUNT) source files..."; start=$$(date +%s); $(MAKE) --no-print-directory build; end=$$(date +%s); echo "Built $(SRC_COUNT) source files in $$((end-start)) seconds."'
    RM        = rm -rf
    MKDIR     = mkdir -p $(dir $@)
    CLEAN_OBJ = $(OBJDIR)
    
    ifeq ($(UNAME_S),Darwin)
        CXXFLAGS += -I/opt/homebrew/include
        LDFLAGS  += -L/opt/homebrew/lib
    endif
endif

# ====================================================================
#   Build Targets and Rules
# ====================================================================

all:
	@echo "Building..."
	@$(TIME_CMD)
	@echo "Build complete."

build: $(OUT)

$(OUT): $(OBJ)
	@$(CXX) $(CXXFLAGS) $(OBJ) -o $(OUT) $(LDFLAGS) $(LIBS)

# Compile object files and auto-create target directories
$(OBJDIR)/%.o: %.cpp
	@$(MKDIR)
	@$(CXX) $(CXXFLAGS) -c $< -o $@

run: all
	@echo "Running game..."
	@./$(OUT)

clean:
	@echo "Cleaning..."
	@$(RM) $(OUT)
	@$(RM) $(OBJDIR) 2>nul || true
	@echo "Clean complete."





