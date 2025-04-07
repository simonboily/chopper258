# chopper 2.58

## Background

`chopper258` is a modern port of the old DOS game, "Chopper Commando", written by Mark Currie in 1990.

It has been translated from Pascal to C, and adapted to work with SDL2.

The game is known to build and run on Ubuntu 18.04 and MacOSX El Capitan, and there is also
a web port via emscripten.

For more background on the project, see this article:

[https://blog.loadzero.com/blog/chopper258](https://blog.loadzero.com/blog/chopper258/)

## Credits

Thanks to Mark Currie for granting permission to publish this port of his game.

## Building and running

### Desktop

`SDL2` is required as a dependency, to install on Ubuntu, do this:

    $ sudo apt-get install libsdl2-dev

To grab the code and build the binary, do this:

    $ git clone https://github.com/loadzero/chopper258.git && cd chopper258
    $ make

To run it:

    $ ./bin/chopper258 

The default scale factor is 3x. To run with a different scale factor:

    $ ./bin/chopper258 2

### Web (Emscripten)

To build the web version, you'll need Emscripten SDK installed and the `EMSDK` environment variable set. 
If you haven't installed Emscripten yet, follow the instructions at: https://emscripten.org/docs/getting_started/downloads.html

Once Emscripten is set up, you can build the web version with:

    $ make web

This will create the following files in the `web` directory:
- `chopper258.html` - The game webpage
- `chopper258.js` - JavaScript support code
- `chopper258.wasm` - WebAssembly binary

To serve the game, run:

    $ cd web
    $ python3 ./server.py
    
Then open `http://localhost:8000/chopper258.html` in your web browser.

## Playing

To get started:

    Press P to enter Practice Mode
    Press Space to continue
    Tap cursor keys to move

The main gameplay controls are:

    left_arrow   LEFT
    right_arrow  RIGHT
    up_arrow     UP
    down_arrow   DOWN
    space        FIRE
    b            BOMB
    m            MISSILE
    n            NUKE
    e            EJECT
    a            AUTOEJECT_TOGGLE

Some extra fun:

    t            TERRAFORM
    c            CHANGE_BACKGROUND_COLOR
    p            CHANGE_PALETTE

