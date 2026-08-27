#include "Renderer.hpp"


Renderer::Renderer( SDL_Window * window )
{
     renderer = SDL_CreateRenderer ( window , -1 , SDL_RENDERER_ACCELERATED || SDL_RENDERER_PRESENTVSYNC ) ;

}


Renderer::~Renderer()
{
    SDL_DestroyRenderer ( renderer ) ;
}


void Renderer::Present()
{

    SDL_RenderPresent ( renderer ) ;

}
