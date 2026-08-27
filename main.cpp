#include "Renderer/Renderer.hpp"
#include "Window/Window.hpp"
#include "InputManager/InputManager.hpp"

int main ( int argc , char * argv[] )
{

    std::unique_ptr<Window> window ;
    std::unique_ptr<Renderer> renderer ;
    InputManager input ;


   if ( SDL_Init ( SDL_INIT_EVERYTHING ) < 0 )
    {
        printf( " error in init %s" , SDL_GetError() ) ;
    }
    else
    {

     window = std::make_unique<Window>( " test " , SDL_WINDOWPOS_CENTERED , SDL_WINDOWPOS_CENTERED , 720 , 720 , false ) ;
     renderer = std::make_unique<Renderer>( window->getWindow() ) ;
    }




    
//



    bool run = true  ;

    while ( run )
    {

      SDL_Event e ;

        input.Update();

        if ( input.hasQuitRequested() ) {
            run = false ;
        }


        renderer->Present() ;


    } ;




    //std:: cout << " here ===> " << SDL_GetKeyName ( SDLK_x ) ; 


    return 0 ;

}