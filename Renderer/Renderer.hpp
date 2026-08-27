#pragma once
#include "../struct.hpp"


class Renderer
{

private:
 
 
   SDL_Renderer  * renderer = nullptr ; 

public:


    Renderer( SDL_Window * window );
    ~Renderer();

    void Present() ;

};


