$(shell mkdir -p bin/game bin/base bin/exe web)

all: bin/chopper258

web: web/chopper258.html

clean:
	rm -rf bin
	rm -rf web/chopper258.*

UNAME := $(shell uname -s)
EMSHELL_FILE := $(shell echo $$EMSDK)/upstream/emscripten/src/shell_minimal.html

# Web compilation settings
EMCC := emcc
EMFLAGS := -O2 -I. -Ibase -Iinclude -s USE_SDL=2 -pthread -sPTHREAD_POOL_SIZE=4 -DNDEBUG -fno-strict-aliasing -flto -std=gnu99

ifeq ($(UNAME),Darwin)
	IFLAGS := -I . -I /Library/Frameworks/SDL2.framework/Headers 
	CFLAGS := -Wno-format -fsanitize=float-divide-by-zero -g -flto -DNDEBUG -fno-strict-aliasing -std=gnu99 $(IFLAGS)
	LDFLAGS := -F /Library/Frameworks/ -framework SDL2
else
	IFLAGS := -I . -I /usr/include/SDL2
	CFLAGS := -rdynamic -g -flto -DNDEBUG -fno-strict-aliasing -O1 -std=gnu99 $(IFLAGS)
	LDFLAGS := -lSDL2 -lpthread -lm
endif
	
bin/%.c.o: %.c Makefile
	gcc $(CFLAGS) -c $< -o $@

bin/base/font.c.o: base/font.c base/font.h base/fontdata.h
bin/base/render.c.o: base/render.c include/base/render_proto.h base/render.h base/shared.h base/sdl.h 
bin/base/sound.c.o: base/sound.c include/base/sound_proto.h base/sound.h base/sdl.h
bin/base/input.c.o: base/input.c include/base/input_proto.h base/input.h base/sdl.h
bin/base/turbo.c.o: base/turbo.c include/base/turbo_proto.h base/shared.h base/turbo.h base/font.h
bin/game/chopper2.c.o: game/chopper2.c base/turbo.h game/mouse.h game/vehicles.h \
	 game/people.h game/bombs.h game/building.h game/explode.h \
	 game/missiona.h game/title.h game/terrain.h game/missions.h
bin/exe/chopper258.c.o: exe/chopper258.c base/shared.h base/sdl.h

bin/chopper258: bin/exe/chopper258.c.o \
	            bin/base/input.c.o \
	            bin/base/sound.c.o \
	            bin/base/render.c.o \
		        bin/game/chopper2.c.o \
			    bin/base/turbo.c.o \
				bin/base/font.c.o
	gcc $(CFLAGS) $^ -o $@ $(LDFLAGS)

# Web target
web/chopper258.html: exe/chopper258.c base/input.c base/sound.c base/render.c game/chopper2.c base/turbo.c base/font.c
	$(EMCC) $(EMFLAGS) $^ -o $@ --shell-file $(EMSHELL_FILE)
